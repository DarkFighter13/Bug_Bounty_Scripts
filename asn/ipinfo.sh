#!/bin/bash

# Function to display help information
help() {
  echo -e "Help Menu:\n"
  echo "  -d string       Domain name"
  echo "  -h flag         Show help menu"
  echo -e "  Usage example:  $0 -d domain.com\n"
  exit 1
}

domain=''

# Process command-line options
while getopts "d:h" opt; do
  case $opt in
    d)
      domain=$OPTARG
      ;;

    h)
      help
      ;;

    \?)
      echo "Invalid Option"
      help
      ;;
  esac
done

# Check if domain is provided
if [ -z "$domain" ]; then
  echo "No Domain Provided. Use option -d followed by the domain name."
  help
else
  echo "Getting $domain info..."
  
  # Get the IP address using dig
  ip=$(dig +answer +short "$domain")
  
  # Check if dig succeeded
  if [ -z "$ip" ]; then
    echo "Could not find IP address for $domain."
    exit 1
  fi
  
  echo "IP: $ip"
  
  # Fetch additional information from ipinfo.io
  response=$(curl -s "ipinfo.io/$ip")
  
  # Check if curl succeeded
  if [ $? -eq 0 ]; then
    echo "$response"
  else
    echo "Failed to retrieve information from ipinfo.io."
    exit 1
  fi
fi
