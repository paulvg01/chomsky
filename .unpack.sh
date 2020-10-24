#!/bin/sh
IFS=$'\n'
sentence="^\"(.*)\""
terms="^\[(.*)\]"
rule=".*>.*"
: > .rulelist
read filename
for line in `cat $filename`; do
	if [[ "$line" =~ $sentence ]]; then
		echo "${BASH_REMATCH[1]}" | sed 's/\s/\n/g' > .sentence
	elif [[ "$line" =~ $terms ]]; then
		echo "${BASH_REMATCH[1]}" | sed 's/,/\n/g' | sed 's/\s//g' > .termlist
	elif [[ "$line" =~ $rule ]]; then
		echo "$line" >> .rulelist
	else
		continue
	fi
done

