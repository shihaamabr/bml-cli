#!/bin/bash

source .env

BML_URL='https://www.bankofmaldives.com.mv/internetbanking/api'
COOKIE=/tmp/bmlcookie
curl -s -c $COOKIE $BML_URL/login \
	--data-raw username=$BML_USERNAME \
	--data-raw password=$BML_PASSWORD \
	--compressed > /dev/null
curl -s -b $COOKIE $BML_URL/profile > /dev/null

curl -s -b $COOKIE $BML_URL/contacts | jq -r '["Account Number","Currency","Account Name","Contact Name"], ["==================================================================="], (.["payload"] | .[] | [.account, .currency, .name, .alias]) | @tsv'

#get this to render nicely in a table, similar to contacts
#curl -s -b $COOKIE $BML_URL/dashboard
