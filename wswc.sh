#!/bin/bash

# Colors for better formatting
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'
reset='\033[0m'

# Function to check system architecture
check_architecture() {
    case "$(uname -m)" in
        x86_64 | x64 | amd64 )
            arch="amd64"
            ;;
        i386 | i686 )
            arch="386"
            ;;
        armv8 | armv8l | arm64 | aarch64 )
            arch="arm64"
            ;;
        armv7l )
            arch="arm"
            ;;
        * )
            echo "Error: Unsupported architecture: $(uname -m)"
            exit 1
            ;;
    esac
}

# Function to download warpendpoint (optional)
download_warpendpoint() {
    if [[ ! -f "<span class="math-inline">PREFIX/bin/warpendpoint" \]\]; then
echo \-e "</span>{yellow}Downloading warpendpoint program..."
        if [[ -n "$arch" ]]; then
            curl -L -o warpendpoint -# --retry 2 "https://raw.githubusercontent.com/Ptechgithub/warp/main/endip/$arch"
            cp warpendpoint "$PREFIX/bin"
            chmod +x "$PREFIX/bin/warpendpoint"
        fi
    fi
}

# Function to generate random IPv4 addresses
generate_ipv4() {
    local iplist=100
    local temp=()
    for (( i=0; i<iplist; i++ )); do
        temp[<span class="math-inline">i\]\=</span>(echo 162.159.$((<span class="math-inline">RANDOM % 256\)\)\.</span>(($RANDOM % 256)))
    done
    # Ensure unique IPs using sorting and removing duplicates
    while [[ <span class="math-inline">\(echo "</span>{temp[@]}" | sed 's/ /\n/g' | sort -u | wc -l) -lt $iplist ]]; do
        temp[<span class="math-inline">i\]\=</span>(echo 162.159.$((<span class="math-inline">RANDOM % 256\)\)\.</span>((<span class="math-inline">RANDOM % 256\)\)\)
\(\(i\+\+\)\)
done
echo "</span>{temp[@]}"
}

# Function to generate random IPv6 addresses
generate_ipv6() {
    local iplist=100
    local temp=()
    for (( i=0; i<iplist; i++ )); do
        temp[<span class="math-inline">i\]\=</span>(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM*2+<span class="math-inline">RANDOM%2\)\)\)\:</span>(printf '%x\n' $(($RANDOM*2+<span class="math-inline">RANDOM%2\)\)\)\:</span>(printf '%x\n' $(($RANDOM*2+<span class="math-inline">RANDOM%2\)\)\)\:</span>(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
    done
    # Ensure unique IPs using sorting and removing duplicates
    while [[ <span class="math-inline">\(echo "</span>{temp[@]}" | sed 's/ /\n/g' | sort -u | wc -l) -lt $iplist ]]; do
        temp[<span class="math-inline">i\]\=</span>(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM*2+<span class="math-inline">RANDOM%2\)\)\)\:</span>(printf '%x\n' $(($RANDOM*2+<span class="math-inline">RANDOM%2\)\)\)\:</span>(printf '%x\n' $(($RANDOM*2+<span class="math-inline">RANDOM%2\)\)\)\:</span>(printf '%x\n' $(($RANDOM*2+<span class="math-inline">RANDOM%2\)\)\)\]\)
\(\(i\+\+\)\)
done
echo "</span>{temp[@]}"
}

# Function to generate WireGuard configuration
generate() {
    # Download wgcf if not found
    if [[ ! -f "<span class="math-inline">PREFIX/bin/wgcf" \]\]; then
echo \-e "</span>{yellow}Downloading wgcf program..."
        curl -L -o wgcf -# --retry 2 "https://raw.githubusercontent.com/WireGuard/wireguard-go/master/bin/wgcf"
        chmod +x
