#!/bin/bash

# Function to ping a potential Warp endpoint IP
function ping_warp_endpoint() {
  local ip="$1"
  if ping -c 1 -W 2 "$ip" &> /dev/null; then
    echo "Found Warp endpoint IP: $ip"
  fi
}

# List of potential Warp endpoint IP prefixes (modify as needed)
warp_prefixes=(
  "100.64."
  "131.0.71."
  "162.158."
  "172.217."
  "192.0.18."
)

# Loop through prefixes and scan for IPs in those ranges
for prefix in "${warp_prefixes[@]}"; do
  for i in {1..254}; do
    ip="$prefix$i"
    ping_warp_endpoint "$ip" &  # Run ping commands asynchronously
  done
done

wait  # Wait for all ping commands to finish
