if [ -f $CREDENTIALS ]
then
	source $CREDENTIALS
	if [ "$LOGIN" = "2" ]
	then
		echo "${red}Password update required${reset}"
		rm $CREDENTIALS 2> /dev/null
		read -p 'Username: ' BML_USERNAME
		read -s -p 'Password: ' BML_PASSWORD
		echo ""
	else
		:
	fi
elif [ ! -f $CREDENTIALS ]
then
	echo "${red}Username or Password in correct${reset}"
	read -p 'Username: ' BML_USERNAME
	read -s -p 'Password: ' BML_PASSWORD
	echo ""
else
	:
fi

source login.sh
