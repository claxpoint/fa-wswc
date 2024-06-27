#!/bin/bash

# Color definitions
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
PLAIN='\033[0m'

# Function to print red colored text
red() {
  echo -e "\033[31m\033[01m$1\033[0m"
}

# Function to print green colored text
green() {
  echo -e "\033[32m\033[01m$1\033[0m"
}

# Function to print yellow colored text
yellow() {
  echo -e "\033[33m\033[01m$1\033[0m"
}

# Function to select client CPU architecture
archAffix() {
  case "<span class="math-inline">\(uname \-m\)" in
i386 \| i686\) echo '386' ;;
x86\_64 \| amd64\) echo 'amd64' ;;
armv8 \| arm64 \| aarch64\) echo 'arm64' ;;
s390x\) echo 's390x' ;;
\*\) red "Unsupported CPU architecture\!" && exit 1 ;;
esac
\}
\# Function to optimize WARP Endpoint IP \(generic\)
endpointyx\(\) \{
\# Download the preferred tool \(thanks to anonymous contributor\)
wget https://raw.githubusercontent.com/claxpoint/fa-wswc/main/u3-Warpel/u3-wswc-</span>(archAffix) -O warp

  # Increase thread limit for optimal Endpoint IP generation
  ulimit -n 102400

  # Make the tool executable and run it silently
  chmod +x warp && ./warp >/dev/null 2>&1

  # Display top 10 optimal Endpoint IPs and instructions
  green "The current optimal Endpoint IP results are as follows and have been saved to result.csv:"
  cat result.csv | awk -F, '$3!="timeout ms" {print}' | sort -t, -nk2 -nk3 | uniq | head -11 | awk -F, '{print "Endpoint "$1" Packet loss rate "$2" Average delay "$3}'
  echo ""
  yellow "How to use it:"
  yellow "1. Replace the default Endpoint IP of the WireGuard node: engage.cloudflareclient.com:2408 with the optimal Endpoint IP of the local network"

  # Clean up temporary files
  rm -f warp ip.txt
}

# Function to generate and optimize WARP IPv4 Endpoint IPs
endpoint4() {
  # Generate a list of preferred IPv4 Endpoint IP segments
  n=0
  iplist=100
  while true; do
    temp[<span class="math-inline">n\]\=</span>(echo 162.159.192.$((<span class="math-inline">RANDOM % 256\)\)\)
n\=</span>(($n + 1))
    if [ $n -ge $iplist ]; then
      break
    fi
    temp[<span class="math-inline">n\]\=</span>(echo 162.159.193.$((<span class="math-inline">RANDOM % 256\)\)\)
n\=</span>(($n + 1))
    if [ $n -ge $iplist ]; then
      break
    fi
    # ... (similar logic for other IP segments)
    temp[<span class="math-inline">n\]\=</span>(echo 188.114.99.$((<span class="math-inline">RANDOM % 256\)\)\)
n\=</span>(($n + 1))
    if [ $n -ge $iplist ]; then
      break
    fi
  done

  # Eliminate duplicates and ensure enough IPs are generated
  while true; do
    if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
      break
    else
      # ... (similar logic to add more IPs if needed)
    fi
  done

  # Write IPs to file and call generic optimization function
  echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u >ip.txt
  endpointyx
}

# Function to generate and optimize WARP IPv6 Endpoint IPs (similar to endpoint4)
endpoint6() {
  # ... (similar logic to endpoint4 for IPv6 addresses)
  endpointyx
}

