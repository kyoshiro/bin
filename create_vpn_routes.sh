#!/bin/bash

# CIDR to route
cidr=$1
# Target ip to route through, itc the vpn gateway address
target=$2

# Function to convert CIDR to subnet and subnet mask
cidr_to_subnet() {
  local cidr="$1"
  subnet=$(ipcalc -n -b "$cidr" | awk '/Address/ {print $2}')
  subnet_mask=$(ipcalc -n -b "$cidr" | awk '/Netmask/ {print $2}')
  echo "route $subnet $subnet_mask $target"
}

cidr_to_subnet "$cidr"
