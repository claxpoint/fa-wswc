#!/bin/bash

# لیست نقاط پایانی WARP
warp_endpoints=(
  "warp.google.com"
  "warp-prod.appspot.com"
  # ... endpoints more
)

# پورت پیش فرض WARP
warp_port=443

# تابع برای اسکن یک نقطه پایانی WARP
function scan_endpoint() {
  endpoint="$1"

  # آدرس IP نقطه پایانی را دریافت کنید
  ip_address=$(dig +short A "$endpoint" | head -n 1)

  # اگر آدرس IP یافت نشد، خطایی را چاپ کنید
  if [ -z "$ip_address" ]; then
    echo "Error: Unable to resolve IP address for endpoint: $endpoint"
    return 1
  fi

  # اسکن نقطه پایانی WARP
  nmap -Pn -sT -p "$warp_port" "$ip_address" | grep "open"

  echo
}

# هر نقطه پایانی WARP را اسکن کنید
for endpoint in "${warp_endpoints[@]}"; do
  scan_endpoint "$endpoint"
done
