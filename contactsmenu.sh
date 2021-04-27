echo ""
echo "Contacts"
echo ""
echo "1 - List Contacts"
echo "2 - Add Contact"
echo "3 - Delete Conact"
echo "4 - Go back"
echo "5 - Exit"
echo ""
printf 'Please Input: '
read -r CONTATCS

if [ "$CONTATCS" = "1" ]
	then
	source listcontacts.sh
elif [ "$CONTATCS" = "2" ]
	then
	source addcontact-menu.sh
elif [ "$CONTATCS" = "3" ]
	then
	source delete contact.sh
elif [ "$CONTATCS" = "4" ]
	then
	source mainmenu.sh
elif [ "$CONTATCS" = "5" ]
	then
	rm $COOKIE
	echo "Cleaning up.."
	exit
else
	clear
	echo "${red}There was an error${reset}" 1>&2
	source contactsmenu.sh
fi
