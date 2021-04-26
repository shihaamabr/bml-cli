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
else
		#Display error if login was not successful and delete cookie
                echo "${red}An error occurred, Please check Username and Password" 1>&2
                rm $COOKIE 2> /dev/null
                exit
fi

#display menu
echo "Menu"
echo ""
echo "1 - Accounts"
echo "2 - Contacts"
echo "3 - Activities"
echo "4 - Services"
echo "5 - Settings"
echo ""
printf 'Please Input: '
read -r MENU

if [ "$MENU" = "1" ]
	then
		curl -s -b $COOKIE $BML_URL/dashboard | jq
elif [ "$MENU" = "2" ]
	then
		echo ""
		echo "Contacts"
		echo ""
		echo "1 - Transfer"
		echo "2 - Add Contact"
		echo "3 - Delete Contact"
		echo ""
		printf 'Please Input: '
		read -r CONTACS

		if [ "$CONTACS" = "1" ]
			then
				curl -s -b $COOKIE $BML_URL/contacts | jq -r '["Account Number","Currency","Account Name","Contact Name"], ["==================================================================="], (.["payload"] | .[] | [.account, .currency, .name, .alias]) | @tsv'
		elif [ "$CONTACS" = "2" ]
			then
				printf 'Account Number: '
				read -r ACCOUNT_NUMBER
				VALID_NUMBER=$(curl -s -b $COOKIE $BML_URL/validate/account/$ACCOUNT_NUMBER \
						| jq -r .success)
					if [ "$VALID_NUMBER" = "true" ]
						then
							printf 'Name: '
							curl -s -b $COOKIE $BML_URL/validate/account/$ACCOUNT_NUMBER | jq -r .
							read -r ACCOUNT_NAME
							curl -s -b $COOKIE $BML_URL | jq
					else
							echo "${red}Invalid Account" 1>&2
					fi
		elif [ "$CONTACS" = "3" ]
			then
				echo ""
		else
			exit
		fi
elif [ "$MENU" = "3" ]
	then
		curl -s -b $COOKIE $BML_URL/activities | jq
elif [ "$MENU" = "4" ]
	then
		curl -s -b $COOKIE $BML_URL/services/applications/context | jq
elif [ "$MENU" = "5" ]
        then
		curl -s -b $COOKIE $BML_URL/settings | jq
else
	echo "${red}There was an error"
fi

