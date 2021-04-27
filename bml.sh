#!/bin/bash
BML_URL='https://www.bankofmaldives.com.mv/internetbanking/api'
COOKIE=/tmp/bmlcookie

#Setting terminal output colors
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

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
	read -p 'Do you want to save login? [Y/N] ' SAVE_LOGIN

	if [ "$SAVE_LOGIN" = "Y" ]
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

#login and generate cookie
LOGIN=$(curl -s -c $COOKIE $BML_URL/login \
	--data-raw username=$BML_USERNAME \
	--data-raw password=${BML_PASSWORD} \
	--compressed \
		| jq -r .success)
#check if login was success
if [ "$LOGIN" = "true" ]
        then
		#Requesting for User profile after login and regex to grap the Full name
                NAME=$(curl -s -b $COOKIE $BML_URL/profile \
			| awk -F 'fullname":"' '{print $2}' \
			| cut -f1 -d '"')
		#display a Welcome message with fullname
		echo ""
		echo ${green}Welcome ${reset}$NAME
#		curl -s -b $COOKIE $BML_URL/userinfo
		echo ""
		source mainmenu.sh
else
		#Display error if login was not succuessfull and delete cookie
                echo "${red}An error occured, Please check Username and Password" 1>&2
                rm $COOKIE 2> /dev/null
                exit
fi


