#!/bin/bash

source .env

BML_URL='https://www.bankofmaldives.com.mv/internetbanking/api'
COOKIE=/tmp/bmlcookie
curl -s -c $COOKIE $BML_URL/login \
	--data-raw username=$BML_USERNAME \
	--data-raw password=$BML_PASSWORD \
	--compressed > /dev/null
curl -s -b $COOKIE $BML_URL/profile > /dev/null
#curl -s -b $COOKIE $BML_URL/contacts
#curl -s -b $COOKIE $BML_URL/validate/account/7704265806101
curl -s -b $COOKIE $BML_URL/dashboard
