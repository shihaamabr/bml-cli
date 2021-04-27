

printf 'Account Number: '
read -r ACCOUNT_NUMBER
VALID_NUMBER=$(curl -s -b $COOKIE $BML_URL/validate/account/$ACCOUNT_NUMBER \
		| jq -r .success)

if [ "$VALID_NUMBER" = "true" ]
then

	NAME=$(curl -s -b $COOKIE $BML_URL/validate/account/$ACCOUNT_NUMBER \
		| jq -r '.["payload"] | .name')
	CURRENCY=$(curl -s -b $COOKIE $BML_URL/validate/account/$ACCOUNT_NUMBER \
		| jq -r '.["payload"] | .currency')
	echo "Account Name: $NAME"
	echo "Currency: $CURRENCY"
	echo ""
	printf 'Contact Name: '
	read -r CONTACT_NAME
	ADDCONTACT=$(curl -s -b $COOKIE $BML_URL/contacts \
		--data-raw contact_type=IAT \
		--data-raw account=$ACCOUNT_NUMBER \
		--data-raw alias=$CONTACT_NAME \
		--compressed \
		| jq -r .success)

		if [ "$ADDCONTACT" = "true" ]
		then
			echo "Contact added successfully"
		else
			echo "${red}There was an error${reset}"
			source contactsmenu.sh
		fi
else
	echo "${red}Invalid Account${reset}" 1>&2
	source contactsmenu.sh
fi

source contactsmenu.sh

