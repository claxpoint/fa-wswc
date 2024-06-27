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
