if [ ! -f $CREDENTIALS ]
then
	if [ "$LOGIN" = "0" ]
	then
		read -p 'Do you want to save login? [y/N] ' SAVE_LOGIN
		if [ "$SAVE_LOGIN" = "Y" ]
		then
			read -s -p 'Enter Pin: ' PIN
			echo ""
			read -s -p 'Repeat Pin: ' REPEAT_PIN
			if [ "$PIN" = "$REPEAT_PIN" ]
			then
				echo ""
				echo "Your credentials are ${lightgreen}encrypted${reset} and saved in $CREDENTIALS"
				BML_USERNAME=$(echo "${BML_USERNAME}" | openssl enc -e -des3 -base64 -pass pass:${PIN} -pbkdf2)
				BML_PASSWORD=$(echo "${BML_PASSWORD}" | openssl enc -e -des3 -base64 -pass pass:${PIN} -pbkdf2)
				echo "BML_USERNAME='${BML_USERNAME}'" > $CREDENTIALS
				echo "BML_PASSWORD='${BML_PASSWORD}'" >> $CREDENTIALS

			else
				echo ""
				echo "${red}Pin do not match${reset}"
				source savepass.sh
			fi
		elif [ "$SAVE_LOGIN" = "y" ]
                then
                        read -s -p 'Enter Pin: ' PIN
                        echo ""
                        read -s -p 'Repeat Pin: ' REPEAT_PIN
                        if [ "$PIN" = "$REPEAT_PIN" ]
                        then
                                echo ""
                                echo "Your credentials are ${lightgreen}encrypted${reset} and saved in $CREDENTIALS"
                                BML_USERNAME=$(echo "${BML_USERNAME}" | openssl enc -e -des3 -base64 -pass pass:${PIN} -pbkdf2)
                                BML_PASSWORD=$(echo "${BML_PASSWORD}" | openssl enc -e -des3 -base64 -pass pass:${PIN} -pbkdf2)
                                echo "BML_USERNAME='${BML_USERNAME}'" > $CREDENTIALS
                                echo "BML_PASSWORD='${BML_PASSWORD}'" >> $CREDENTIALS

                        else
                                echo ""
                                echo "${red}Pin do not match${reset}"
                                source savepass.sh
                        fi
		else
			:
		fi
	else
		source readpass.sh
	fi
else
	:
fi

BML_USERNAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
BML_PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
source welcome.sh
