#!/bin/sh
read filename
echo "$filename" | bash .unpack.sh
let alldone=1
bash .parse.sh
until [[ `cat .sentence` == `cat .oldsentence` ]]; do
	cat .sentence > .oldsentence
	bash .parse.sh
done
echo $(echo $(cat .sentence) | sed 's/\n/ /g' | sed 's/.*/\u&/').
