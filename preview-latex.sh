#!/bin/sh

# Aidan Bird 2021
#
# preview a latex document; for use in vim.
#

output_path=/tmp
cmd_usage="usage: $(basename "$0") [Path to latex file]"
[ $# -lt 1 ] && echo "$cmd_usage" && exit -1
doc_name="$(basename "$1" '.tex')"
compile-latex.sh "$1" "$output_path"
[ $? != 0 ] && exit -1
pgrep -f "$READER .*$doc_name\.pdf"
if [ $? != 0 ]
then
    $READER "$output_path/$doc_name.pdf" &
    disown
fi
exit 0
