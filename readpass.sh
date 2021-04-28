
if [ -f $CREDENTIALS ]
then
	source $CREDENTIALS
elif [ "$LOGIN" = "2" ]
then
	if [ -f $CREDENTIALS ]
	then
		echo "${red}Saved Credentials has been changed${reset}"
		rm $CREDENTIALS
	else
		echo "${red}Username or Password incorrect${reset}"
	fi
	read -p 'Username: ' BML_USERNAME
	read -s -p 'Password: ' BML_PASSWORD
	echo ""

elif [ ! -f $CREDENTIALS ]
then
	echo "${red}Password file not found in $CREDENTIALS${reset}"
	read -p 'Username: ' BML_USERNAME
	read -s -p 'Password: ' BML_PASSWORD
	echo ""
else
	:
fi


source login.sh
