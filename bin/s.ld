#!/bin/bash 
# intercept ld call, add rpath argument to make sure all needed shared libraries will be found at runtime
# even if LD_LIBRARY_PATH does not allow to find them
#
allParams=("$@")     # collect arguments to ld
# for i in "${allParams[@]}" ; do
#   echo $i
# done
# 
TRUE_LD=/usr/bin/ld    # the actual loader
n=0
nParams=${#allParams[*]}
static=0        # start with static mode off
LibPath=()      # library paths
LibList=()      # library names
#
# we might want to  put what follows at the end of the rpath list rather than at the beginning
RpathList='-rpath $ORIGIN/../lib -rpath $ORIGIN/../lib64'   # frequent place to find libraries
#
unset PATHUSED
declare -A PATHUSED
PATHUSED["/usr/lib"]=1         # ignore /usr/lib and /usr/lib64 as they are part of default rpath
PATHUSED["/usr/lib64"]=1
while ((n < nParams)); do
    p=${allParams[n]}                            # current argument
    p2=${allParams[$((n+1))]}                    # next argument
    if [[ "${p:0:3}" == -L/ ]]; then             # -L/absolute/path
        LibPath+=("${p:2}")
#
    elif [[ "$p" == -L ]]; then                  # -L [/]some/path
        LibPath+=("${p2}")
        ((n = n + 1))
#
    elif [[ "$p" == -l && ${static} == 0 ]]; then  # -l name_of_library in static mode
        LibList+=("${p2}")
        ((n = n + 1))
#
    elif [[ "${p:0:2}" == -l && ${static} == 0 ]]; then  # -lname_of_library in static mode
        LibList+=("${p:2}")
#
    elif [[ "$p" == -dynamic-linker ]]; then     # ignore name that follows -dynamic-linker
        ((n = n + 1))
#
    elif [[ "$p" == -Bstatic ]]; then            # static mode, will ignore library names from now on
#
    elif [[ "$p" == -static ]]; then             # static mode, will ignore library names from now on
        static=1
#
    elif [[ "$p" == -Bdynamic ]]; then           # dynamic mode, will collect library names from now on
        static=0
#
    elif [[ "$p" == -rpath ]]; then              # explicit rpath, use canonical path if path starts with /
        path="${p2}"
        [[ ${p2} == /* ]] && path="$(readlink -f ${p2})" && allParams[$((n+1))]="${path}"
        PATHUSED["${path}"]=1 
        [[ -n ${LD_WRAPPER_DEBUG} ]] && echo "EXPLICIT rpath = ${path} (${p2})"
#
    elif [[ "$p" =~ ^[^-].*\.so($|\.) ]]; then   # direct reference to a shared library, so add its canonical path to rpath.
        path="$(readlink -e $(dirname "$p"))";
        PATHUSED["${path}"]=1
        RpathList="${RpathList} -rpath ${path}"
    fi
    ((n = n + 1))
done
[[ -n ${LD_WRAPPER_DEBUG} ]] &&  echo LibPath=${LibPath[@]}
[[ -n ${LD_WRAPPER_DEBUG} ]] &&  echo LibList=${LibList[@]}
#
unset LIBS_SEEN
declare -A LIBS_SEEN   # list of already encountered dynamic libraries
#
for i in ${LibPath[@]}; do         # loop over path list to find libraries
  path="$(readlink -f ${i})"
  [[ -n ${LD_WRAPPER_DEBUG} ]] &&    [[ -n ${PATHUSED["$path"]} ]] && echo "<<< IGNORING $path >>>" && continue
  [[ -n ${PATHUSED["$path"]} ]] && continue            # this library path is already in list of "seen" paths, next please
  for j in ${LibList[@]}; do                           # loop over library names for this path
      foundlib=${LIBS_SEEN["$j"]}
      if [ -z "$foundlib" -a -f "$i/lib$j.so" ]; then  # new library name
          RpathList="${RpathList} -rpath ${path}"      # add to rpathlist
          LIBS_SEEN["$j"]=1                            # mark library as "seen"
          break
      fi
  done
  PATHUSED["${path}"]=1                                # mark library path as "used"
done
# add $ORIGIN/../lib and $ORIGIN/../lib64 as a last source of libraries
# RpathExtra='-rpath $ORIGIN/../lib -rpath $ORIGIN/../lib64'
# RpathList="${RpathList} ${RpathExtra}"
[[ -n ${LD_WRAPPER_DEBUG} ]] &&  echo RpathList=${RpathList[@]}
[[ -n ${LD_WRAPPER_DEBUG} ]] &&  set -x
exec ${TRUE_LD} "${allParams[@]}" ${RpathList[@]}   # and now call the real ld with added rpath list
