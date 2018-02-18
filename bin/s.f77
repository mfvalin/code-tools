#!/bin/ksh
#. s.get_compiler_rules.dot
COMPILING_FORTRAN=YES
. s.get_compiler_rules.dot
[[ -n $Verbose ]] && set -x
$FC ${SourceFile} $FC_options ${FFLAGS} \
      $(s.prefix "${Dprefix}" ${DEFINES} ) \
      $(s.prefix "${Iprefix}" ${INCLUDES} ${EC_INCLUDE_PATH}) \
      $(s.prefix "${Lprefix}" ${LIBRARIES_PATH} ${EC_LD_LIBRARY_PATH}) \
      $(s.prefix "${lprefix}" ${LIBRARIES} ${SYSLIBS} ) \
      "$@"
