#! /bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

root=$(pwd)

wait_func() {
  read -p "PRESS ENTER TO CONTINUE" wait
}

if [ -z $1 ]; then
  printf "${RED}Run with 'sudo ./quikscan.sh #.#.#.#'${NC}\n"
  exit 1
fi

printf "${BLUE}[*]Testing if host is alive...${NC}\n"
fping -c1 -t300 $1 2>/dev/null 1>/dev/null
if [ "$?" = 0 ]; then
  printf "${GREEN}[+]Host is up!${NC}\n"
  printf "${BLUE}[*]Running RustScan...${NC}\n"
  sudo rustscan $1
  str1="[*]Outputting to $1"
  str2=".rust${NC}\n"
  str3=$str1$str2
  printf "${BLUE}$str3"
  sudo rustscan $1 > ~/$1.txt
  printf "${BLUE}[*]Running Dig Reverse DNS Search...${NC}\n"
  sudo dig -x $1
  str1="[*]Outputting to $1"
  str2=".dig${NC}\n"
  str3=$str1$str2
  printf "${BLUE}$str3"
  sudo dig -x $1 > ~/$1.dig
  printf "${BLUE}"
  read -p "[*]Is you IP p[u]blic or p[r]ivate?[u/r]: " iptype
  if [ $iptype == "u" ]; then
    printf "${BLUE}[*]Retrieving Geo-Info...${NC}\n"
    sudo curl https://ipinfo.io/$1
    str1="[*]Outputting to $1"
    str2=".geo${NC}\n"
    str3=$str1$str2
    printf "${BLUE}$str3"
    sudo curl https://ipinfo.io/$1 > ~/$1.geo
  else
    printf "${RED}[*]Private IPs are limited to your LAN only.${NC}\n"
  fi
else
  printf "${RED}[!]Host is down.${NC}\n"
fi
