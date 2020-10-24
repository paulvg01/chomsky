#!/bin/sh

function pullrules {
        IFS=$'\n'
        for rule in `cat .rulelist`; do
                if [[ "$rule" =~ $regex ]]; then
                        echo $rule | sed -e 's/.*>\s//g'
                fi
        done
}


IFS=$'\n'
for word in `cat .sentence`; do
	allwords+=( $word )
done
for term in `cat .termlist`; do
	allterms+=( $term )
done
IFS=$' '
: > .sentence
for index in ${!allwords[@]}; do
	currentword="${allwords[$index]}"
	if [[ " ${allterms[@]} " =~ " $currentword " ]]; then
		echo "$currentword" >> .sentence
	else
		regex="^$currentword "
		pullrules | sort -R | tail -n 1 >> .sentence
	fi
done
echo "$(cat .sentence | sed 's/ /\n/g')" > .sentence
