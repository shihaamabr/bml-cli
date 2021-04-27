#!/bin/bash


#importing saved credentials
source .env 2> /dev/null

#what to do if credentials not saved
if [ "$BML_USERNAME" = "" ]
then
	echo ${red}Credentials not found in .env file${reset}
	echo ""
	read -p 'Username: ' BML_USERNAME
	read -s -p 'Password: ' BML_PASSWORD
	echo ""
	echo "Do ${red}NOT${reset} save password if password contain '|' '^' '$' '&' ';' ':' '(' ')'  "
	read -p 'Do you want to save login? [y/N] ' SAVE_LOGIN

	if [ "$SAVE_LOGIN" = "Y" ]
	then
		echo BML_USERNAME=$BML_USERNAME > .env
		echo BML_PASSWORD=$BML_PASSWORD >> .env
	elif [ "$SAVE_LOGIN" = "y" ]
	then
		echo BML_USERNAME=$BML_USERNAME > .env
		echo BML_PASSWORD=$BML_PASSWORD >> .env
	else
		:
	fi
	echo ""
else
	:
fi

source login.sh
