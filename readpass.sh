if [ -f $CREDENTIALS ]
then
	source $CREDENTIALS
	echo "Attempting to login with saved credentials"
	if [ "$LOGIN" = "2" ]
	then
		echo "${red}Login Required${reset}"
		rm $CREDENTIALS 2> /dev/null
		read -p 'Username: ' BML_USERNAME
		read -s -p 'Password: ' BML_PASSWORD
		echo ""
	else
		:
	fi
elif [ ! -f $CREDENTIALS ]
then
	echo "${red}Login Required${reset}"
	read -p 'Username: ' BML_USERNAME
	read -s -p 'Password: ' BML_PASSWORD
	echo ""
else
	:
fi

source login.sh
