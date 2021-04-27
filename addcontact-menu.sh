echo ""
echo "Add Contact"
echo ""
echo "1 - BML"
echo "2 - Domestic"
echo "3 - International"
echo "4 - BillPay"
echo "5 - Go back"
echo "6 - Exit"
echo ""
printf 'Select contact type[1]: '
read -r CONTACT_TYPE

if [ "$CONTACT_TYPE" = "1" ]
	then
	source addcontact-bml.sh
elif [ "$CONTACT_TYPE" = "" ]
	then
	source addcontact-bml.sh 
elif [ "$CONTATC_TYPE" = "2" ]
	then
	echo "${red}WORK IN PROGRESS${reset}"
	source addcontact-menu.sh
elif [ "$CONTATC_TYPE" = "3" ]
	then
	echo "${red}WORK IN PROGRESS${reset}"
	source addcontact-manu.sh
elif [ "$CONTATC_TYPE" = "4" ]
	then
	echo "${red}WORK IN PROGRESS${reset}"
	source addcontact-manu.sh
elif [ "$CONTATC_TYPE" = "5" ]
	then
	source contactsmenu.sh
elif [ "$CONTATC_TYPE" = "6" ]
	then
	rm $COOKIE
	exit
else
	clear
	echo "${red}There was an error${reset}" 1>&2
	source contactsmenu.sh
fi
