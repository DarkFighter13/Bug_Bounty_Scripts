#!/bin/bash
#echo -e "\e[34m------------------------------------\e[0m"
echo -e "\n\e[34m             \e[32mcrt.sh \e[34mscript          \e[0m"
echo -e "\e[34m     Made By Eng: \e[32mMohamed Gamil       \e[0m"
echo -e "\e[34m     Github Link \e[32mhttps://github.com/MGFocus/       \e[0m"
echo -e "\e[34m--------------------------------------------------\e[0m"

if [ -z $1 ]; then
	echo "usage: ./crt.sh domain.com"
	exit

else
	echo -e "\e[34m *\e[32m SubDomain Collecting Starting:\e[0m \n"
	target="https://crt.sh/?q=$1"
	wget $target -O index.html 2>error.txt
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
rm -f newtestSubs.txt testSubs.txt index.html error.txt
echo -e "\e[34m *\e[32m Finished Successfully, All SubDomains Was Saved In \e[34mcrtSubs.txt \e[32mFile \e[0m"
fi
