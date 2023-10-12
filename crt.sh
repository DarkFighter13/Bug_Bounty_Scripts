#!/bin/bash

if [ -z $1 ]; then
	echo "usage: ./crt.sh domain.com"
	exit

else
	target="https://crt.sh/?q=$1"
	wget $target -O index.html
	cat index.html | grep -i "<TD>" | grep ".com" | cut -d ">" -f 2 | cut -d "<" -f 1 >> testSubs.txt
	for sub in $(cat testSubs.txt); do
		if [[ $sub == "*."* ]]; then
			subdomain="${sub#*.}"
			echo $subdomain >> newtestSubs.txt 
		else 
			echo $sub >> newtestSubs.txt
		fi
	done
cat newtestSubs.txt | sort | uniq >> crtSubs.txt
rm -f newtestSubs.txt testSubs.txt index.html
fi