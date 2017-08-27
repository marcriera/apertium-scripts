#! /bin/bash
filename_in="$1"
filename_out="$2"
paradigm="$3"
> $filename_out
while read -r line
do
    word="$line"
    space='<b/>'
    word2=$word
    word2=${word2/' '/$space}
    word2=${word2/' '/$space}
    word2=${word2/' '/$space}
    word2=${word2/' '/$space}
    word2=${word2/' '/$space}
    word2=${word2/' '/$space}
    word2=${word2/' '/$space}
    word2=${word2/' '/$space}
    word2=${word2/' '/$space}
    word2=${word2/' '/$space}
    echo '<e lm="'$word'"><i>'$word2'</i><par n="'$paradigm'"/></e>' >> $filename_out
done < "$filename_in"
exit 0
