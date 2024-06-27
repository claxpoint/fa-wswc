#!/bin/bash

# Script to find Cloudflare Warp endpoints and generate WireGuard configurations

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to download and execute a script
download_and_execute() {
    script_url="<span class="math-inline">1"
script\_name\="</span>{script_url##*/}"

    if [ ! -f "$script_name" ]; then
        curl -L -o "$script_name" "$script_url"
    fi

    chmod +x "$script_name"
    ./"$script_name"
}

# Function to generate IPv4 addresses
generate_ipv4() {
    n=0
    ip_list=100

    while true; do
        temp[<span class="math-inline">n\]\=</span>(echo 162.159.192.$((<span class="math-inline">RANDOM % 256\)\)\)
n\=</span>((n + 1))

        if [ $n -ge $ip_list ]; then
            break
        fi

        temp[<span class="math-inline">n\]\=</span>(echo 162.159.193.$((<span class="math-inline">RANDOM % 256\)\)\)
n\=</span>((n + 1))

        if [ $n -ge $ip_list ]; then
            break
        fi

        temp[<span class="math-inline">n\]\=</span>(echo 162.159.195.$((<span class="math-inline">RANDOM % 256\)\)\)
n\=</span>((n + 1))

        if [ $n -ge $ip_list ]; then
            break
        fi

        temp[<span class="math-inline">n\]\=</span>(echo 188.114.96.$((<span class="math-inline">RANDOM % 256\)\)\)
n\=</span>((n + 1))

        if [ $n -ge $ip_list ]; then
            break
        fi

        temp[<span class="math-inline">n\]\=</span>(echo 188.114.97.$((<span class="math-inline">RANDOM % 256\)\)\)
n\=</span>((n + 1))

        if [ $n -ge $ip_list ]; then
            break
        fi

        temp[<span class="math-inline">n\]\=</span>(echo 188.114.98.$((<span class="math-inline">RANDOM % 256\)\)\)
n\=</span>((n + 1))

        if [ $n -ge $ip_list ]; then
            break
        fi

        temp[<span class="math-inline">n\]\=</span>(echo 188.114.99.$((<span class="math-inline">RANDOM % 256\)\)\)
n\=</span>((n + 1))

        if [ $n -ge $ip_list ]; then
            break
        fi
    done

    while true; do
        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $ip_list ]; then
            break
        else
            temp[<span class="math-inline">n\]\=</span>(echo 162.159.192.$((<span class="math-inline">RANDOM % 256\)\)\)
n\=</span>((n + 1))
        fi

        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $ip_list ]; then
            break
        else
            temp[<span class="math-inline">n\]\=</span>(echo 162.159.193.$((<span class="math-inline">RANDOM % 256\)\)\)
n\=</span>((n + 1))
        fi

        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $ip_list ]; then
            break
        else
            temp[<span class="math-inline">n\]\=</span>(echo 162.159.195.$((<span class="math-inline">RANDOM % 256\)\)\)
n\=</span>((n + 1))
        fi

        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $ip_list ]; then
            break
        else
            temp[<span class="math-inline">n\]\=</span>(echo 188.114.96.$((<span class="math-inline">RANDOM % 256\)\)\)
n\=</span>((n + 1))
        fi

        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -
