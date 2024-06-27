#!/bin/bash

# Define color constants for cleaner output
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
PLAIN='\033[0m'

# Function to print colored text
function colored_echo() {
  local color="<span class="math-inline">1"
shift
echo \-e "</span>{color}<span class="math-inline">\*</span>{PLAIN}"
}

# Function to select client CPU architecture
function arch_affix() {
  case "<span class="math-inline">\(uname \-m\)" in
i386 \| i686 \) echo '386';;
x86\_64 \| amd64 \) echo 'amd64';;
armv8 \| arm64 \| aarch64 \) echo 'arm64';;
s390x \) echo 's390x';;
\* \) colored\_echo "</span>{RED}" "Unsupported CPU architecture!"; exit 1;;
  esac
}

# Function to optimize WARP Endpoint IP (combined logic)
function optimize_endpoint() {
  local ip_type="$1"  # "4" for IPv4, "6" for IPv6

  # Generate a list of preferred IP segments
  local iplist=100
  local n=0
  declare -A temp  # Use associative array for efficient unique IP storage
  while [[ <span class="math-inline">\(wc \-l <<< "</span>{temp[@]}") -lt $iplist ]]; do
    case $ip_type in
      4)
        temp["<span class="math-inline">n"\]\=</span>(echo 162.159.{192..204}.$(($RANDOM % 256)))
        ((n++))
        temp["<span class="math-inline">n"\]\=</span>(echo 188.114.{96..99}.$(($RANDOM % 256)))
        ((n++))
        ;;
      6)
        temp["<span class="math-inline">n"\]\=</span>(echo "[2606:4700:d0::$(printf '%x\n' $(($RANDOM * 2 + <span class="math-inline">RANDOM % 2\)\)\)\)\:\:</span>(printf '%x\n' $(($RANDOM * 2 + <span class="math-inline">RANDOM % 2\)\)\)\)\:\:</span>(printf '%x\n' $(($RANDOM * 2 + <span class="math-inline">RANDOM % 2\)\)\)\)\:\:</span>(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2)))]")
        ((n++))
        temp["<span class="math-inline">n"\]\=</span>(echo "[2606:4700:d1::$(printf '%x\n' $(($RANDOM * 2 + <span class="math-inline">RANDOM % 2\)\)\)\)\:\:</span>(printf '%x\n' $(($RANDOM * 2 + <span class="math-inline">RANDOM % 2\)\)\)\)\:\:</span>(printf '%x\n' $(($RANDOM * 2 + <span class="math-inline">RANDOM % 2\)\)\)\)\:\:</span>(printf '%x\n' $(($RANDOM * 2 + <span class="math-inline">RANDOM % 2\)\)\)\]"\)
\(\(n\+\+\)\)
;;
esac
done
\# Write unique IPs to ip\.txt
echo "</span>{temp[@]}" | tr ' ' '\n' | sort -u > ip.txt

  # Download tool (assuming URL doesn't change)
  wget https://raw.githubusercontent.com/TheyCallMeSecond/WARP-Endpoint-IP/main/files/warp-linux-<span class="math-inline">\(arch\_affix\) \-O warp
\# Set thread limit, run tool, and suppress output
ulimit \-n 102400
chmod \+x warp && \./warp \>/dev/null 2\>&1
\# Display results
colored\_echo "</span>{GREEN}" "Optimal Endpoint IP results (saved to result.csv):"
  cat result.csv | awk -F, '$3!="timeout ms" {print}' | sort -t, -nk2 -nk3 | uniq | head -11 | awk -F, '{print "Endpoint "$1" Packet loss rate "$2" Average delay "<span class="math-inline">3\}'
echo ""
colored\_echo "</span>{YELLOW}" "How to use it:"
  colored_echo "<span class="math-inline">\{YELLOW\}" "1\. Replace the default Endpoint IP of the WireGuard node\: engage\.cloudflareclient\.com\:2408 with the optimal Endpoint IP of the local network"
\# Cleanup
rm \-f warp ip\.txt
\}
\# Function to display menu and handle user input
function menu\(\) \{
clear
echo "\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#"
colored\_echo "</span>{RED}" "  WARP Endpoint IP one-click optimization script"  "${
