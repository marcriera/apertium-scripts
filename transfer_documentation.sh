#! /bin/bash
filename_in="$1"
filename_out="$2"
> $filename_out
temp_file=$(mktemp)
cat $filename_in | sed 's/<!--/\x0<!--/g;s/-->/-->\x0/g' | grep -zv '^<!--' | tr -d '\0' > $temp_file
section=1
rulenumber=1
rule=""
echo "Looking for macros..."
echo '{|class="wikitable"' >> $filename_out
echo '! style="width: 5%" | #' >> $filename_out
echo '! style="width: 25%" | Macro name' >> $filename_out
echo '! style="width: 10%" | Arguments' >> $filename_out
echo '! style="width: 60%" | Description' >> $filename_out
while read -r line
do
    if [ "$section" = "1" ]
	then
        if grep '<def-macro' <<< $line
        then
            macro=$(cut -d'&' -f2 <<< ${line//'"'/'&'})
            pattern=$(cut -d'&' -f4 <<< ${line//'"'/'&'})
            echo '|-' >> $filename_out
            echo '!'$rulenumber >> $filename_out
            echo '|'$macro >> $filename_out
            echo '| style="text-align:center" |'$pattern >> $filename_out
            if grep 'comment=' <<< $line
            then
                description=$(cut -d'&' -f6 <<< ${line//'"'/'&'})
                echo '|'$description >> $filename_out
            else
                echo '|Undocumented macro!' >> $filename_out
            fi
            (( rulenumber++ ))
        elif grep '<section-rules>' <<< $line
        then
            section="2"
            rulenumber="1"
            echo '|}' >> $filename_out
            echo "Looking for transfer rules..."
            echo "" >> $filename_out
            echo '{|class="wikitable"' >> $filename_out
            echo '! style="width: 5%" | #' >> $filename_out
            echo '! style="width: 25%" | Rule pattern' >> $filename_out
            echo '! style="width: 70%" | Description' >> $filename_out
        fi
    else
        if grep '<rule' <<< $line
        then
            if [ "$rule" != "" ]
            then
                echo "" >> $filename_out
                echo '|'$rule >> $filename_out
            fi
            if grep 'comment=' <<< $line
            then
                rule=$(cut -d'&' -f2 <<< ${line//'"'/'&'})
            else
                rule="Undocumented rule!"
            fi
            echo '|-' >> $filename_out
            echo '!'$rulenumber >> $filename_out
            echo -n '|' >> $filename_out
            (( rulenumber++ ))
        elif grep '<pattern-item' <<< $line
        then
            pattern_item=$(cut -d'&' -f2 <<< ${line//'"'/'&'})
            echo -n $pattern_item" " >> $filename_out
        elif grep '</section-rules>' <<< $line
        then
            break
        fi
    fi
done < $temp_file
echo "" >> $filename_out
echo '|'$rule >> $filename_out
echo '|}' >> $filename_out
echo "Done"
rm $temp_file
exit 0
