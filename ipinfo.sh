#!/bin/bash

if [ -z "$1" ]; then
    echo -e "\e[32mUsage: ./ipinfo domain.com\e[0m"
else 
    ip=$(dig +short "$1" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | awk '{print $1}')
    echo $ip
    curl -s ipinfo.io/$ip | jq .
fi
