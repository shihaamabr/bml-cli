if [ -f $CREDENTIALS ]
then
	source $CREDENTIALS
#	echo "Attempting to login with saved credentials"
	read -s -p 'Enter Pin: ' PIN
	BML_USERNAME=$(echo ${BML_USERNAME} |openssl enc -d -des3 -base64 -pass pass:${PIN} -pbkdf2)
	BML_PASSWORD=$(echo ${BML_PASSWORD} |openssl enc -d -des3 -base64 -pass pass:${PIN} -pbkdf2)
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
