#!/bin/bash

# رنگ ها
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
RESET='\033[0m'

# URL لیست Endpoint IP های Warp
ENDPOINT_IP_URL="https://raw.githubusercontent.com/Ptechgithub/warp/master/warp_endpoints.txt"

# مسیر ذخیره سازی کانفیگ ها
CONFIG_DIR="$HOME/warp-configs"

# بررسی مجوز sudo
if [ $(whoami) != "root" ]; then
  echo -e "${RED}برای اجرای این اسکریپت به مجوز sudo نیاز دارید.${RESET}"
  exit 1
fi

# ایجاد پوشه ذخیره سازی کانفیگ ها (در صورت وجود)
mkdir -p $CONFIG_DIR

# دانلود لیست Endpoint IP ها
echo -e "${YELLOW}در حال دانلود لیست Endpoint IP ها...${RESET}"
wget -qO- $ENDPOINT_IP_URL | tee $CONFIG_DIR/warp_endpoints.txt

# اسکن Endpoint IP ها
echo -e "${YELLOW}در حال اسکن Endpoint IP ها...${RESET}"
while read -r endpoint_ip; do
  # پینگ Endpoint IP
  if ping -c 1 $endpoint_ip > /dev/null; then
    echo -e "${GREEN}$endpoint_ip: فعال${RESET}"

    # دریافت کانفیگ WireGuard برای V2ray
    v2ray_config_url="https://api.cfwarp.com/v1/reg/$endpoint_ip?platform=linux_x64"
    echo -e "${YELLOW}در حال دریافت کانفیگ WireGuard برای V2ray...${RESET}"
    curl -s $v2ray_config_url | jq . | tee $CONFIG_DIR/$endpoint_ip-v2ray.json

    # دریافت کانفیگ WireGuard برای Nekobox
    nekobox_config_url="https://api.cfwarp.com/v1/reg/$endpoint_ip?platform=android"
    echo -e "${YELLOW}در حال دریافت کانفیگ WireGuard برای Nekobox...${RESET}"
    curl -s $nekobox_config_url | jq .data | base64 -w 0 | tee $CONFIG_DIR/$endpoint_ip-nekobox.conf

    # دریافت کانفیگ WireGuard (روش 1)
    echo -e "${YELLOW}در حال دریافت کانفیگ WireGuard (روش 1)...${RESET}"
    wg genkey | tee private_key
    public_key=$(wg pubkey < private_key)
    wg genkey | tee peer_key
    peer_public_key=$(wg pubkey < peer_key)
    wireguard_config_1="$CONFIG_DIR/$endpoint_ip-wireguard1.conf"
    echo "[Interface]" > $wireguard_config_1
    echo "PrivateKey = $(cat private_key)" >> $wireguard_config_1
    echo "[Peer]" >> $wireguard_config_1
    echo "PublicKey = $peer_public_key" >> $wireguard_config_1
    echo "Endpoint = $endpoint_ip:51820" >> $wireguard_config_1
    echo "AllowedIPs = 0.0.0.0/0" >> $wireguard_config_1

    # دریافت کانفیگ WireGuard (روش 2)
    wireguard_config_url="https://api.cfwarp.com/v1/reg/$endpoint_ip?platform=linux_iptables"
    echo -e "${YELLOW}در حال دریافت کانفیگ WireGuard (روش 2)...${RESET}"
    curl -s $wireguard_config_url | tee $CONFIG_DIR/$endpoint_ip-wireguard2.conf

  else
    echo -e "${RED}$endpoint_ip: غیرفعال${RESET}"
  fi
done < $CONFIG_DIR/warp_endpoints.txt

echo -e "${GREEN}اسکن با موفقیت به پایان رسید! کانفیگ ها در $CONFIG_DIR ذخیره شده اند.${RESET}"
