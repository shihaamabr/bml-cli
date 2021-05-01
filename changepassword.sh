

			read -s -p 'Enter Current Password: ' OLD_PASSWORD
			echo ""
			read -s -p 'Enter New Password: ' NEW_PASSWORD
			echo ""
			read -s -p 'Repeat New Password: ' REPEAT_NEWPASSWORD
			if [ "$NEW_PASSWORD" = "$REPEAT_NEWPASSWORD" ]
			then
				echo "Select OTP Method:"
				echo "1 - Mobile"
				echo "2 - Email"
				echo ""
				echo "Please input: "
				read -r OTPCHANNEL
				if [ "$OTPCHANNEL" = "1" ]
				then
					OTPCHANNEL=mobile
				elif [ "$OTPCHANNEL" = "2" ]
				then
					OTPCHANNEL=email
				else
					echo "${red}Invalid Input${reset}"
				fi


		curl -s -b $COOKIE $BML_URL/user/changepassword' \
		--data-raw currentPassword=$OLD_PASSWORD \
		--data-raw newPassword=$NEW_PASSWORD \
		--data-raw newPasswordConfirmation=$REPEAT_NEWPASSWORD \
		--data-raw channel=$OTPCHANNEL \
		--compressed

		curl -s -b $COOKIE $BML_URL/user/changepassword' \
		--data-raw currentPassword=$OLD_PASSWORD \
		--data-raw newPassword=$NEW_PASSWORD \
		--data-raw newPasswordConfirmation=$REPEAT_NEWPASSWORD \
		--data-raw channel=$OTPCHANNEL
		--data-raw otp=$OTP \
		--compressed
