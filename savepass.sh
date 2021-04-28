#echo "Do ${red}NOT${reset} save password if password contain '|' '^' '$' '&' ';' ':' '(' ')'  "

if [ ! -f $CREDENTIALS ]
then
	if [ "$LOGIN" = "0" ]
	then
		read -p 'Do you want to save login? [y/N] ' SAVE_LOGIN
		if [ "$SAVE_LOGIN" = "Y" ]
		then
			echo BML_USERNAME=''${BML_USERNAME}'' > $CREDENTIALS
			echo BML_PASSWORD=''${BML_PASSWORD}'' >> $CREDENTIALS

		elif [ "$SAVE_LOGIN" = "y" ]
		then
			echo BML_USERNAME=''${BML_USERNAME}'' > $CREDENTIALS
			echo BML_PASSWORD=''${BML_PASSWORD}'' >> $CREDENTIALS
		else
			:
		fi
	else
		source readpass.sh
	fi
else
	:
fi

source welcome.sh
