#! /bin/sh
filename_in1="$1"
filename_in2="$2"
filename_out="$3"
one="<e><p><l>"
two="<s n="np"/><s n="top"/><s n="sg"/></l>"
three="<r>"
four="<s n="np"/><s n="loc"/></r></p></e>"
> $filename_out
awk -F'<i>' '{print "<e><p><l>"_$2 >> "tmp1"}' $filename_in1
awk -F'</i>' '{print $1_"<s n=\"np\"/><s n=\"cog\"/><s n=\"sg\"/></l>" >> "tmp2"}' tmp1
awk -F'<i>' '{print "<r>"_$2 >> "tmp3"}' $filename_in2
awk -F'</i>' '{print $1_"<s n=\"np\"/><s n=\"cog\"/><s n=\"mf\"/><s n=\"sp\"/></r></p></e>" >> "tmp4"}' tmp3
paste -d "" tmp2 tmp4 >> $filename_out
rm tmp1
rm tmp2
rm tmp3
rm tmp4
awk -F'<i>' '{print "<e r=\"LR\"><p><l>"_$2 >> "tmp1"}' $filename_in1
awk -F'</i>' '{print $1_"<s n=\"np\"/><s n=\"cog\"/><s n=\"pl\"/></l>" >> "tmp2"}' tmp1
awk -F'<i>' '{print "<r>"_$2 >> "tmp3"}' $filename_in2
awk -F'</i>' '{print $1_"<s n=\"np\"/><s n=\"cog\"/><s n=\"mf\"/><s n=\"sp\"/></r></p></e>" >> "tmp4"}' tmp3
paste -d "" tmp2 tmp4 >> $filename_out
rm tmp1
rm tmp2
rm tmp3
rm tmp4
exit 0
