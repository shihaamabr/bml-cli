#!/bin/bash

#Making cookie and credentials dir
mkdir -p ~/.config/bml-cli/
mkdir -p ~/.cache/bml-cli/

#Setting intial variables
BML_URL='https://www.bankofmaldives.com.mv/internetbanking/api'
COOKIE=~/.cache/bml-cli/cookie
CREDENTIALS=~/.config/bml-cli/.env

#Setting terminal output colors
red=`tput setaf 1`
green=`tput setaf 2`
brown=`tput setaf 3`
blue=`tput setaf 4`
pink=`tput setaf 5`
cyan=`tput setaf 6`
gray=`tput setaf 7`
darkgray=`tput setaf 8`
lightred=`tput setaf 9`
lightgreen=`tput setaf 10`
yellow=`tput setaf 11`
reset=`tput sgr0`

source osdetect.sh 2>/dev/null
source readpass.sh
