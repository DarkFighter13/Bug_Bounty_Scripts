#!/bin/bash

function help(){
  echo "HELP MENU"
  echo "  used for collecting cidr ranges belongs to specific ASN number from whois database"
  echo "  usage: $0 -a asn-number-here"
  echo "  -a	asn number"
  echo "  -h	print help menu"
}

asn=""

while getopts "a:h" opt; do
  case $opt in

    a)
      asn=$OPTARG ;;

    h)
      help
      exit 0 ;;

    \?)
      echo "invalid option: -$OPTARG"
	echo ""
      help
      exit 1 ;;
  esac
done

if [ -z $asn ]; then
  echo "asn number required"
  help
  exit 1
else
  whois -h whois.radb.net -- "-i origin AS$asn" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]{1,2}'
fi
