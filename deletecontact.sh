

printf "Enter Contact ID: "
read -r CONATACT_ID
DELETESUCCESS=$(curl -s -b $COOKIE $BML_URL/contacts/$CONATACT_ID \
		--data-raw _method=delete \
		--compressed \
		| jq -r .code)

if [ "$DELETESUCCESS" = "0" ]
then
	echo Contact Deleted
	source contactsmenu.sh
else
	echo "${red}There was an error${reset}"
	source contactsmenu.sh
fi
