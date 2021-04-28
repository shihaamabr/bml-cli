#!/bin/bash



#Setting intial variables
BML_URL='https://www.bankofmaldives.com.mv/internetbanking/api'
COOKIE=/tmp/bmlcookie
CREDENTIALS=.env

#Setting terminal output colors
red="\033[0;32m"
green="\033[0;31m"
reset="\033[0m"

source readpass.sh
