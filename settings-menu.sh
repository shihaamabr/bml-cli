echo ""
echo "Settings"
echo ""
echo "1 - Logout and Delete saved credentials"
echo "2 - Change Password"
echo "3 - Go Back"
echo ""
printf 'Please Input: '
read -r SETTINGS

if [ "$SETTINGS" = "1" ]
then
	source logout.sh
elif [ "$SETTINGS" = "2" ]
then
	source changepassword.sh
elif [ "$SETTINGS" = "3" ] || [ "$SETTINGS" = "back" ]
then
	source mainmenu.sh
elif [ "$SETTINGS" = "clear" ]
then
	sleep 0.2
	clear
	source settings-menu.sh
elif [ "$SETTINGS" = "exit" ]
then
	echo "Cleaning up.."
	rm $COOKIE
	sleep 0.2
	exit
else
	echo ${red}Invalid input:${yellow} $SETTINGS ${reset} 1>&2
	source settings-menu.sh
fi
