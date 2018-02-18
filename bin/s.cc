#!/bin/ksh
export COMPILING_C=yes
. s.get_compiler_rules.dot
[[ -n $Verbose ]] && set -x
if [[ -n $WILL_LINK ]]
then
  $CC ${SourceFile} $CC_options ${CFLAGS} \
      $(s.prefix "" ${DEFINES} ) \
      $(s.prefix "-I" ${INCLUDES} ${EC_INCLUDE_PATH}) \
      $(s.prefix "-L" ${LIBRARIES_PATH} ${EC_LD_LIBRARY_PATH}) \
      $(s.prefix "-l" ${LIBRARIES} ) \
      "$@"
else
  $CC ${SourceFile} ${CC_options_NOLD:-${CC_options}} ${CFLAGS} \
      $(s.prefix "" ${DEFINES} ) \
      $(s.prefix "-I" ${INCLUDES} ${EC_INCLUDE_PATH}) \
      "$@"
fi