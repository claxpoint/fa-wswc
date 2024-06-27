#!/bin/bash

#colors
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'
rest='\033[0m'

case "$(uname -m)" in
	x86_64 | x64 | amd64 )
	    cpu=amd64
	;;
	i386 | i686 )
        cpu=386
	;;
	armv8 | armv8l | arm64 | aarch64 )
        cpu=arm64
	;;
	armv7l )
        cpu=arm
	;;
	* )
	echo "The current architecture is $(uname -m), not supported"
	exit
	;;
esac

cfwarpIP() {
    if [[ ! -f "$PREFIX/bin/warpendpoint" ]]; then
        echo "Downloading warpendpoint program"
        if [[ -n $cpu ]]; then
            curl -L -o warpendpoint -# --retry 2 https://raw.githubusercontent.com/Ptechgithub/warp/main/endip/$cpu
            cp warpendpoint $PREFIX/bin
            chmod +x $PREFIX/bin/warpendpoint
        fi
    fi
}

endipv4(){
	n=0
	iplist=100
	while true
	do
		temp[$n]=$(echo 162.159.192.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 162.159.193.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 162.159.195.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.96.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.97.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.98.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.99.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
	done
	while true
	do
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.192.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.193.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.195.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.96.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.97.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.98.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.99.$(($RANDOM%256)))
			n=$[$n+1]
		fi
	done
}

endipv6(){
	n=0
	iplist=100
	while true
	do
		temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
	done
	while true
	do
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
			n=$[$n+1]
		fi
	done
}

generate() {
    if ! command -v wgcf &>/dev/null; then
        echo -e "${purple}*********************${rest}"
        echo -e "${green}Downloading the required file ...${rest}"
        if [[ "$(uname -o)" == "Android" ]]; then
			if ! command -v curl &>/dev/null; then
			    pkg install curl -y
			fi
            if [[ -n $cpu ]]; then
                curl -o "$PREFIX/bin/wgcf" -L "https://raw.githubusercontent.com/Ptechgithub/warp/main/endip/wgcf"
                chmod +x "$PREFIX/bin/wgcf"
            fi
        else
            curl -L -o wgcf -# --retry 2 "https://github.com/ViRb3/wgcf/releases/download/v2.2.22/wgcf_2.2.22_linux_$cpu"
            cp wgcf "$PREFIX/usr/local/bin"
            chmod +x "$PREFIX/usr/local/bin/wgcf"
        fi
    fi
    echo -e "${purple}*********************${rest}"
    echo -e "${green}Generating free warp config . please wait ...${rest}"
    echo ""
    rm wgcf-account.toml >/dev/null 2>&1
    wgcf register --accept-tos
    echo -e "${blue}***********************${rest}"
    wgcf generate
  
    if [ -f wgcf-profile.conf ]; then
        show
    else
        echo -e "${red}wgcf-profile.conf not found in current path or failed to install${rest}"
    fi
}

v2ray() {
  urlencode() {
    local string="$1"
    local length="${#string}"
    local urlencoded=""
    for (( i = 0; i < length; i++ )); do
      local c="${string:$i:1}"
      case $c in
        [a-zA-Z0-9.~_-]) urlencoded+="$c" ;;
        *) printf -v hex "%02X" "'$c"
           urlencoded+="%${hex: -2}"
      esac
    done
    echo "$urlencoded"
  }

  PrivateKey=$(awk -F' = ' '/PrivateKey/{print $2}' wgcf-profile.conf)
  Address=$(awk -F' = ' '/Address/{print $2}' wgcf-profile.conf | tr '\n' ',' | sed 's/,$//;s/,/, /g')
  PublicKey=$(awk -F' = ' '/PublicKey/{print $2}' wgcf-profile.conf)
  MTU=$(awk -F' = ' '/MTU/{print $2}' wgcf-profile.conf)
  
  WireguardURL="wireguard://$(urlencode "$PrivateKey")@$Endip_v46?address=$(urlencode "$Address")&publickey=$(urlencode "$PublicKey")&mtu=$(urlencode "$MTU")#Peyman_WireGuard"

  echo $WireguardURL
}

show() {
    echo ""
    sleep1
    clear
    if [ -s result.csv ]; then
	    Endip_v46=$(awk 'NR==2 {split($1, arr, ","); print arr[1]}' result.csv)
	    sed -i "s/Endpoint =.*/Endpoint = $Endip_v46/g" wgcf-profile.conf
    else
	    Endip_v46="engage.cloudflareclient.com:2408"
	fi
    echo -e "${purple}************************************${rest}"
    echo -e "${purple}*   👇${green}Here is WireGuard Config👇   ${purple}*${rest}"
    echo -e "${purple}************************************${rest}"
    echo -e "${cyan}       👇Copy for :${yellow}[Nekobox] 👇${rest}"
    echo ""
    echo -e "${green}$(cat wgcf-profile.conf)${rest}"
    echo ""
    echo -e "${purple}************************************${rest}"
    echo -e "${cyan}       👇Copy for :${yellow}[V2rayNG] 👇${rest}"
    echo ""
    echo -e "${green}$(v2ray)${rest}"
    echo ""
    echo -e "${purple}************************************${rest}"
    echo -e "${yellow}1) ${blue}if you couldn't paste it in ${yellow}V2rayNG${blue} or ${yellow}Nekobox${blue}, copy it to a text editor and remove any extra spaces.${rest}"
    echo ""
    echo -e "${yellow}2) ${blue}If you're using ${yellow}IPv6 ${blue}in ${yellow}V2rayNG, ${blue}place IPV6 inside${yellow} [ ] ${blue}example: ${yellow}[2606:4700:d0::1836:b925:ebb2:5eb1] ${rest}"
    echo -e "${purple}************************************${rest}"
}

endipresult() {
    echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u > ip.txt
    ulimit -n 102400
    chmod +x warpendpoint >/dev/null 2>&1
    if command -v warpendpoint &>/dev/null; then
        warpendpoint
   else
        ./warpendpoint
    fi
    
    clear
    cat result.csv | awk -F, '$3!="timeout ms" {print} ' | sort -t, -nk2 -nk3 | uniq | head -11 | awk -F, '{print "Endpoint "$1" Packet Loss Rate "$2" Average Delay "$3}'
    Endip_v4=$(cat result.csv | grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+" | head -n 1)
    Endip_v6=$(cat result.csv | grep -oE "\[.*\]:[0-9]+" | head -n 1)
    delay=$(cat result.csv | grep -oE "[0-9]+ ms|timeout" | head -n 1)
    echo ""
    echo -e "${green}Results Saved in result.csv${rest}"
    echo ""
    if [ "$Endip_v4" ]; then
        echo -e "${purple}************************************${rest}"
        echo -e "${purple}*           ${yellow}Best IPv4:Port${purple}         *${rest}"
        echo -e "${purple}*                                  *${rest}"
        echo -e "${purple}*          ${cyan}$Endip_v4${purple}     *${rest}"
        echo -e "${purple}*           ${cyan}Delay: ${green}[$delay]        ${purple}*${rest}"
        echo -e "${purple}************************************${rest}"
    elif [ "$Endip_v6" ]; then
        echo -e "${purple}********************************************${rest}"
        echo -e "${purple}*          ${yellow}Best [IPv6]:Port                ${purple}*${rest}"
        echo -e "${purple}*                                          *${rest}"
        echo -e "${purple}* ${cyan}$Endip_v6${purple} *${rest}"
        echo -e "${purple}*           ${cyan}Delay: ${green}[$delay]               ${purple}*${rest}"
        echo -e "${purple}********************************************${rest}"
    else
        echo -e "${red} No valid IP addresses found.${rest}"
    fi
    rm warpendpoint >/dev/null 2>&1
    rm -rf ip.txt
    exit
}

# Run wire-g and get Wireguard Config
wire-g() {
    if [ ! -f "$PREFIX/bin/wire-g" ]; then
        if [ -f "$HOME/.termux" ]; then
            if ! command -v wg &> /dev/null || ! command -v jq &> /dev/null || ! command -v xz &> /dev/null || ! command -v bzip2 &> /dev/null; then
                pkg update -y && pkg upgrade -y
                pkg install wireguard-tools jq xz-utils bzip2 -y
            fi
        else
            if ! command -v wg &> /dev/null || ! command -v jq &> /dev/null || ! command -v xz &> /dev/null || ! command -v bzip2 &> /dev/null; then
                apt update -y
                apt install wireguard-tools jq xz-utils bzip2 -y
            fi
        fi
        curl -o $PREFIX/bin/wire-g https://raw.githubusercontent.com/Ptechgithub/warp/main/wire-g.sh
        chmod +x $PREFIX/bin/wire-g
        echo ""
        echo -e "${purple}*********************${rest}"
        echo -e "${yellow}Run --> ${green}wire-g${rest}"
        echo -e "${yellow}Help --> ${green}wire-g -h${rest}"
        echo -e "${purple}*********************${rest}"
    else
        echo ""
        echo -e "${purple}*********************${rest}"
        echo -e "${yellow}Run --> ${green}wire-g${rest}"
        echo -e "${yellow}Help --> ${green}wire-g -h${rest}"
        echo -e "${purple}*********************${rest}"
    fi
}

clear
echo -e "${cyan}By --> Peyman * Github.com/Ptechgithub * ${rest}"
echo ""
echo -e "${purple}*********************${rest}"
echo -e "${purple}* ${green}Endpoint Scanner ${purple} *${rest}"
echo -e "${purple}* ${green}wire-g installer ${purple} *${rest}"
echo -e "${purple}*********************${rest}"
echo -e "${purple}[1] ${blue}Preferred${green} IPV4${purple}  * ${rest}"
echo -e "${purple}                    *${rest}"
echo -e "${purple}[2] ${blue}Preferred${green} IPV6${purple}  * ${rest}"
echo -e "${purple}                    *${rest}"
echo -e "${purple}[3] ${blue}Get ${green}free Config${purple} *${rest}"
echo -e "${purple}                    *${rest}"
echo -e "${purple}[4] ${blue}Install ${green}wire-g${purple}  *${rest}"
echo -e "${purple}                    *${rest}"
echo -e "${purple}[${red}0${purple}] Exit            *${rest}"
echo -e "${purple}*********************${rest}"
echo -en "${cyan}Enter your choice: ${rest}"
read -r choice
case "$choice" in
    1)
        echo -e "${purple}*********************${rest}"
        cfwarpIP
        endipv4
        endipresult
        Endip_v4
        ;;
    2)
        echo -e "${purple}*********************${rest}"
        cfwarpIP
        endipv6
        endipresult
        Endip_v6
        ;;
    3)
        generate
        ;;
    4)
        wire-g
        ;;
    0)
        echo -e "${purple}*********************${rest}"
        echo -e "${cyan}By 🖐${rest}"
        exit
        ;;
    *)
        echo -e "${yellow}********************${rest}"
        echo "Invalid choice. Please select a valid option."
        ;;
esac
