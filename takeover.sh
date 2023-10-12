#!/bin/bash
if [ -z $1 ]; then
    echo "Take An Option:"
    echo "(1) For File"
    echo "(2) For OneSubDomain"
    read option

    if [ $option -ne 1 && $option -ne 2 ]; then
        echo "Enter 1 OR 2"
        read option2
        $option=$option2
    fi

    if [ $option -eq 1 ]; then
        echo "Enter File Path"
        read file
	for sub in $(cat "$file"); do
	    subzy r --target "$sub" 
        done
    else
        if [ $option -eq 2 ]; then
            echo "Enter The Only SubDomain"
            read onesub
            subzy r --target "$onesub" 
	fi
    fi
else
    file=$1
    for sub in $(cat "$file"); do
        subzy r --target "$sub" 
    done
fi
