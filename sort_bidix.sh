#! /bin/bash
filename_in="$1"
filename_out="$2"
> $filename_out
sed -e s/"<l>"/"#"/g $filename_in | sort -k 2,2 -t '#' | sed -e s/"#"/"<l>"/g > $filename_out
exit 0
