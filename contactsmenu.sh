echo ""
echo "Contacts"
echo ""
echo "1 - List Contacts"
echo "2 - Add Contact"
echo "3 - Delete Contact"
echo "4 - Go back"
echo ""
printf 'Please Input: '
read -r CONTACTS

if [ "$CONTACTS" = "1" ]
then
	source listcontacts.sh
elif [ "$CONTACTS" = "2" ]
then
	source addcontact-menu.sh
elif [ "$CONTACTS" = "3" ]
then
	source deletecontact.sh
elif [ "$CONTACTS" = "4" ] || [ "$CONTACTS" = "back" ]
then
	sleep 0.2
	source mainmenu.sh
elif [ "$CONTACTS" = "clear" ]
then
	sleep 0.2
	clear
	source contactsmenu.sh
elif [ "$CONTACTS" = "exit" ]
then
	echo "Cleaning up.."
	rm $COOKIE
	sleep 0.2
	exit
else
	echo ${red}Invalid input:${yellow} $CONTACTS ${reset} 1>&2
	source contactsmenu.sh
fi
