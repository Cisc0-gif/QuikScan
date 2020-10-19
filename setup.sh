#! /bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

printf "${BLUE}[*]Downloading RustScan source...${NC}"
sudo wget https://github.com/RustScan/RustScan/releases/download/1.10.0/rustscan_1.10.0_amd64.deb
sudo dpkg -i rustscan_1.10.0_amd64.deb
sudo mv quikscan.sh /usr/local/bin
