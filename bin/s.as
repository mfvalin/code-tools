#!/bin/ksh
. s.get_compiler_rules.dot
AS=${AS:-as}
echo $AS $AS_options $AS_LD_options "$@"
$AS $AS_options $AS_LD_options "$@"
