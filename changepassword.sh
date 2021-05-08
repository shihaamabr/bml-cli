read -s -p 'Enter Current Password: ' OLD_PASSWORD
echo ""
echo ""

while true; do
read -s -p 'Enter New Password: ' NEW_PASSWORD
echo ""
read -s -p 'Repeat New Password: ' REPEAT_NEWPASSWORD
echo ""
if [ "$NEW_PASSWORD" = "$REPEAT_NEWPASSWORD" ]
then
	sleep 0.2
	echo ""
	break
else
	echo "${red}Password do not match${reset}"
	echo "Try again"
	echo ""
fi
done

while true; do
echo "Select OTP Method:"
echo "1 - Mobile"
echo "2 - Email"
echo ""
read -p "Please input: " OTPCHANNEL

if [ "$OTPCHANNEL" = "1" ] || [ "$OTPCHANNEL" = "mobile" ]
	then
		OTPCHANNEL=mobile
	break
elif [ "$OTPCHANNEL" = "2" ] || [ "$OTPCHANNEL" = "email" ]
	then
		OTPCHANNEL=email
	break
else
	echo "${red}Invalid Input${reset}"
	echo ""
fi
done

OLDPASSCHECHECK=$(curl -s -b $COOKIE $BML_URL/user/changepassword \
			--data-raw currentPassword=$OLD_PASSWORD \
			--data-raw newPassword=$NEW_PASSWORD \
			--data-raw newPasswordConfirmation=$REPEAT_NEWPASSWORD \
			--data-raw channel=$OTPCHANNEL \
			--compressed \
			| jq -r .success)

if [ "$OLDPASSCHECHECK" != "true" ]
	then
		source changepassword.sh
else
	:
fi

if [ "$OTPCHANNEL" = "mobile" ]
	then
	ECHOOTPCHANNEL=$PHONE
elif [ "$OTPCHANNEL" = "email" ]
	then
	ECHOOTPCHANNEL=$EMAIL
fi

echo ""
echo "${lightgreen}OTP sent to ${yellow}${ECHOOTPCHANNEL}${reset}"
read -p 'Enter OTP: ' OTP
echo ""
PASSCHANGED=$(curl -s -b $COOKIE $BML_URL/user/changepassword \
		--data-raw currentPassword=$OLD_PASSWORD \
		--data-raw newPassword=$NEW_PASSWORD \
		--data-raw newPasswordConfirmation=$REPEAT_NEWPASSWORD \
		--data-raw channel=$OTPCHANNEL \
		--data-raw otp=$OTP \
		--compressed \
		| jq -r .success)

OLD_PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
NEW_PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
REPEAT_NEWPASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)

if [ "$PASSCHANGED" != "true" ]
	then
		echo "${red}Failed to change password${reset}"
else
	echo "${lightgreen}Password changed succesfully ${reset}"
	rm $CREDENTIALS
	source readpass.sh
fi
