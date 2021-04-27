#!/bin/bash
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


