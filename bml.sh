#!/bin/bash



#Setting intial variables
BML_URL='https://www.bankofmaldives.com.mv/internetbanking/api'
COOKIE=/tmp/bmlcookie

#Setting terminal output colors
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`


source password.sh
