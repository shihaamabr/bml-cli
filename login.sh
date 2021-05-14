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
		if [ "$OS" = "macos" ]
		then
			open $BML_RESETPASS
		elif [ "$OS" = "windows" ]
		then
			cmd.exe /C START $BML_RESETPASS
		elif [ "$OS" = "android" ]
		then
			am start -a android.intent.action.VIEW -d $BML_RESETPASS
		else
			xdg-open $BML_RESETPASS
		fi
		source readpass.sh
elif [ "$LOGIN" = "2" ]
	then
		source readpass.sh
elif [ "$LOGIN" = "37" ]
	then
		echo "${red}Down for Maintenance${reset}" 1>&2
		echo "Try again later"
		exit
else
		echo "${red}Unknown Error${reset}" 1>&2
		exit
fi

