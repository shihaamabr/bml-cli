#!/bin/bash
#login and generate cookie

LOGIN=$(curl -s -c $COOKIE $BML_URL/login \
	--data-raw username=$BML_USERNAME \
	--data-raw password=${BML_PASSWORD} \
	--compressed \
		| jq -r .code)
#check if login was success
if [ "$LOGIN" = "0" ]
        then
		source savepass.sh
elif [ "$LOGIN" = "20" ]
	then
		echo "${red}Account Locked!${reset}"
		echo "${lightred}Please reset password and login again.${reset}"
		echo ""
		if [ "$MAC" = "true" ]
		then
		open https://www.bankofmaldives.com.mv/internetbanking/forgot_password
		else
		xdg-open https://www.bankofmaldives.com.mv/internetbanking/forgot_password
		fi
		source readpass.sh
elif [ "$LOGIN" = "2" ]
	then
		source readpass.sh
else
		echo "${red}Unknown Error${reset}" 1>&2
		exit
fi


