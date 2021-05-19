#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1
CONFIG=~/.config/bml-cli/config
CREDENTIALS=~/.config/bml-cli/.credentials
COOKIE=~/.cache/bml-cli/.cookie
BML_RESETPASS='https://www.bankofmaldives.com.mv/internetbanking/forgot_password'

#Setting terminal output colors
red=`tput setaf 1`
#errorred=`tput setaf 196`
#validgreen=`tput setaf 82`
green=`tput setaf 46`
brown=`tput setaf 3`
blue=`tput setaf 4`
pink=`tput setaf 5`
cyan=`tput setaf 39`
gray=`tput setaf 7`
darkgray=`tput setaf 8`
lightred=`tput setaf 9`
lightgreen=`tput setaf 10`
yellow=`tput setaf 11`
reset=`tput sgr0`
# Colors
G='\e[01;32m'      # GREEN TEXT
R='\e[01;31m'      # RED TEXT
Y='\e[01;33m'      # YELLOW TEXT
B='\e[01;34m'      # BLUE TEXT
V='\e[01;35m'      # VIOLET TEXT
Bl='\e[01;30m'     # BLACK TEXT
C='\e[01;36m'      # CYAN TEXT
W='\e[01;37m'      # WHITE TEXT
BGBL='\e[1;30;47m' # Background W Text Bl
N='\e[0m'          # How to use (example): echo "${G}example${N}"
loadBar=' '        # Load UI

##Setting Up Funcations
animate(){
	PID=$!
	h=0
	anim='⠋⠙⠴⠦'
	while [ -d /proc/$PID ]; do
		h=$(((h + 1) % 4))
		sleep 0.05
	printf "\r${@} [${anim:$h:1}]"
	done
}
initialize(){
	mkdir -p ~/.config/bml-cli/
	mkdir -p ~/.cache/bml-cli/
	echo "# DO NOT EDIT THIS MANUALLY!!" > $CREDENTIALS
	echo "BML_USERNAME='' # Your encrypted BML Username" >> $CREDENTIALS
	echo "BML_PASSWORD='' # Your encrypted BML Password" >> $CREDENTIALS
	echo "# DO NOT EDIT THIS UNLESS NECESSARY!!" > $CONFIG
	echo "I_AM_HYPOCRITE='false' # This is for MacOS Users ONLY" >> $CONFIG
	echo "I_AM_SODU='false' # This is for WSL Users ONLY" >> $CONFIG
	echo "" >> $CONFIG
	echo "BML_URL='https://www.bankofmaldives.com.mv/internetbanking/api' # BML API URL  " >> $CONFIG
}

check_connection(){
	PING=$(ping www.bankofmaldives.com.mv -c 2 2> /dev/null | grep -oE 0%)
	if [ "$PING" != "0%" ]
	then
		echo ${red}Check your connection and try again.${reset}
		exit
	fi
	DOS=$(curl -s https://www.bankofmaldives.com.mv/ | grep -oE "error code: 1020")
	if [ "$DOS" = "error code: 1020" ]
	then
		echo ${red}Access denied${reset}
		echo Try again later
		exit
	fi
}

os_detect(){
	WSL1=$(uname -r | grep -oE Microsoft)
	WSL2=$(uname -r | grep -oE microsoft)
	MAC=$(uname -a | grep -oE Darwin | tail -n1)
	ANDROID=$(uname -a | grep -oE Android)
	if [ "$WSL1" = "Microsoft" ] || [ "$WSL2" = "microsoft" ]
	then
		OS=windows
		if [ "$I_AM_SODU" != "true" ]
		then
			echo ${red}Please check $CONFIG and configure accordingly.${reset}
			exit
		fi
	elif [ "$MAC" = "Darwin" ]
	then
		OS=macos
		export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
		if [ "$I_AM_HYPOCRITE" != "true" ]
		then
			echo ${red}Please check $CONFIG and configure accordingly.${reset}
			exit
		fi
	elif [ "$ANDROID" = "Android" ]
	then
		 OS=android
	fi
	banner
}
##################################################################
banner(){
	clear
	echo "${red}"
	echo "██████╗░███╗░░░███╗██╗░░░░░  ░█████╗░██╗░░░░░██╗"
	echo "██╔══██╗████╗░████║██║░░░░░  ██╔══██╗██║░░░░░██║"
	echo "██████╦╝██╔████╔██║██║░░░░░  ██║░░╚═╝██║░░░░░██║"
	echo "██╔══██╗██║╚██╔╝██║██║░░░░░  ██║░░██╗██║░░░░░██║"
	echo "██████╦╝██║░╚═╝░██║███████╗  ╚█████╔╝███████╗██║"
	echo "╚═════╝░╚═╝░░░░░╚═╝╚══════╝  ░╚════╝░╚══════╝╚═╝"
	echo "${reset}"
}
display_welcome(){
	echo ""
	echo ${green}Welcome ${reset}$NAME
	echo ""
}
display_user_info(){
	echo ${cyan}Phone${reset}: $PHONE
	echo ${cyan}Email${reset}: $EMAIL
	echo ${cyan}Birthday${reset}: $DOB
	echo ${cyan}ID Card${reset}: $IDCARD
	echo ""
}
####################################################################
readpin(){
	read -s -p 'Enter Pin: ' PIN
	echo ""
	CHECK_PIN=$(echo ${BML_USERNAME} | openssl enc -d -des3 -base64 -pass pass:${PIN} -pbkdf2  2>&1 | grep -oE bad)
	if [ "$CHECK_PIN" = "bad bad"  ]
	then
		echo ${R}Incorrect Pin${N}
		readpin
	fi
	banner
	BML_USERNAME_UNSAFE=$(echo ${BML_USERNAME} | openssl enc -d -des3 -base64 -pass pass:${PIN} -pbkdf2)
	BML_PASSWORD_UNSAFE=$(echo ${BML_PASSWORD} | openssl enc -d -des3 -base64 -pass pass:${PIN} -pbkdf2)
	login
}

wipe_credentials(){
	sed -i "s@BML_USERNAME=.*\$@BML_USERNAME='' # Your encrypted BML Username @" $CREDENTIALS
	sed -i "s@BML_PASSWORD=.*\$@BML_PASSWORD='' # Your encrypted BML Password @" $CREDENTIALS
}
urandom(){
	BML_USERNAME_UNSAFE=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
	BML_PASSWORD_UNSAFE=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
	BML_USERNAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
	BML_PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
	REPEAT_PIN=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
	NEW_PIN=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
}
savepass(){
	if [ "$BML_USERNAME" = "" ]  && [ "$BML_PASSWORD" = "" ]
	then
		read -p 'Do you want to save login? [y/N] ' SAVE_LOGIN
		if [ "$SAVE_LOGIN" = "Y" ] || [ "$SAVE_LOGIN" = "y" ]
		then
			read -s -p 'Enter New Pin: ' NEW_PIN
			echo ""
			read -s -p 'Repeat Pin: ' REPEAT_PIN
			if [ "$NEW_PIN" = "$REPEAT_PIN" ]
			then
				echo ""
				BML_USERNAME=$(echo "${BML_USERNAME_UNSAFE}" | openssl enc -e -des3 -base64 -pass pass:${NEW_PIN} -pbkdf2)
				BML_PASSWORD=$(echo "${BML_PASSWORD_UNSAFE}" | openssl enc -e -des3 -base64 -pass pass:${NEW_PIN} -pbkdf2)
				#encrypt_user #& initanimate "Encrypting Username"
				#encrypt_pass #& initanimate "Encrypting Password"
				echo "Your credentials are ${lightgreen}encrypted${reset} and saved in $CREDENTIALS"
				sed -i "s@BML_USERNAME=.*\$@BML_USERNAME='${BML_USERNAME}' # Your encrypted BML Username @" $CREDENTIALS
				sed -i "s@BML_PASSWORD=.*\$@BML_PASSWORD='${BML_PASSWORD}' # Your encrypted BML Password @" $CREDENTIALS
			else
				echo ""
				echo ${R}Pin do not match${N}
				savepass
			fi
		else
			echo Password not saved.
		fi
	else
		:
	fi
	select_profile #	urandom && select_profile
}
################################################################################################

################################################################################################
login(){
	LOGIN=$(curl -s -c $COOKIE $BML_URL/login \
	--data-raw username=$BML_USERNAME_UNSAFE \
	--data-raw password=${BML_PASSWORD_UNSAFE} \
		| jq -r .code)
	if [ "$LOGIN" = "0" ]
        then
		echo ${lightgreen}Login success${reset}
		savepass
	elif [ "$LOGIN" = "20" ]
	then
		banner
		account_locked
		sleep 1.5
		banner
		echo "${red}Account Locked!${reset}"
		echo "${lightred}Please reset password and login again.${reset}"
		enter_credentials
	elif [ "$LOGIN" = "2" ]
	then
		banner
		echo ${red}Password or Username Incorrect${reset}
		wipe_credentials
		enter_credentials
	elif [ "$LOGIN" = "37" ]
	then
		echo "${red}Down for Maintenance${reset}" 1>&2
		echo "Try again later"
		exit
	else
		echo "${red}Unknown Error${reset}" 1>&2
		exit
	fi
}
################################################################################################

################################################################################################
account_locked(){
	if [ "$OS" = "macos" ]
	then
		open $BML_RESETPASS
	elif [ "$OS" = "windows" ]
	then
		cmd.exe /C START $BML_RESETPASS
	elif [ "$OS" = "android" ]
	then
		am start -a android.intent.action.VIEW -d $BML_RESETPASS
	else
		xdg-open $BML_RESETPASS
	fi
}
################################################################################################

################################################################################################
enter_credentials(){
	#echo ""
	read -p 'Username: ' BML_USERNAME_UNSAFE
	read -s -p 'Password: ' BML_PASSWORD_UNSAFE
	echo ""
	login
}
################################################################################################

################################################################################################
select_profile(){
REQPRO=$(curl -s -b $COOKIE $BML_URL/profile)
PERSONALPROFILE=$(echo $REQPRO \
	| jq -r '.payload | .profile | .[] | .profile' \
	| head -n 1)
curl -s -b $COOKIE $BML_URL/profile \
	--data-raw profile=$PERSONALPROFILE \
	--compressed > /dev/null
}
################################################################################################

################################################################################################
userinfo(){
	USERINFO=$(curl -s -b $COOKIE $BML_URL/userinfo)
	SUCCESS=$(echo $USERINFO | jq -r .success)
	if [ "$SUCCESS" != "true" ]
	then
		echo "Login Required"
		init_login
		banner
		userinfo
	fi
	USERINFO=$(echo $USERINFO | jq -r '.["payload"] | .["user"]')
	NAME=$(echo $USERINFO | jq -r .fullname)
	PHONE=$(echo $USERINFO | jq -r .mobile_phone)
	EMAIL=$(echo $USERINFO | jq -r .email)
	DOB=$(echo $USERINFO | jq -r .birthdate |cut -d 'T' -f 1)
	IDCARD=$(echo $USERINFO | jq -r .idcard)
}
################################################################################################

################################################################################################
accounts(){
	echo $API_DASHBOARD \
		| jq -r '.payload | .dashboard |.[] | (.alias, .account, .currency, .availableBalance)'
}
################################################################################################
api_dashboard(){
	API_DASHBOARD=$(curl -s -b $COOKIE $BML_URL/dashboard)
	SUCCESS=$(echo $API_DASHBOARD | jq -r .success)
	if [ "$SUCCESS" != "true" ]
	then
		echo "Login Required"
		init_login
		banner
		api_dashboard
	fi
}

################################################################################################
list_contacts(){
	echo $API_CONATACTS | jq -r '["ID","Account Number","Currency","Account Name","Contact Name"], ["==================================================================="], (.["payload"] | .[] | [.id, .account, .currency, .name, .alias]) | @tsv'
}
################################################################################################
api_contacts(){
	API_CONATACTS=$(curl -s -b $COOKIE $BML_URL/contacts)
	SUCCESS=$(echo $API_CONATACTS | jq -r .success)
	if [ "$SUCCESS" != "true" ]
	then
		echo "Login Required"
		init_login
		banner
		api_contacts
	fi
}

################################################################################################
transfer(){
#	banner
	accounts
	echo ""
	echo "Select debit account"
	echo "Enter credit account"
}
################################################################################################

################################################################################################
api_account(){
API_ACCOUNT=$(curl -s -b $COOKIE $BML_URL/validate/account/$ACCOUNT_NUMBER)
}
################################################################################################

################################################################################################
add_contact(){
printf 'Account Number: '
read -r ACCOUNT_NUMBER
api_account
VALID_NUMBER=$(echo $API_ACCOUNT | jq -r .success)

if [ "$VALID_NUMBER" = "true" ]
then

	ACCOUNT_NAME=$(echo $API_ACCOUNT | jq -r '.["payload"] | .name')
	CURRENCY=$(echo $API_ACCOUNT | jq -r '.["payload"] | .currency')
	echo "Account Name: $ACCOUNT_NAME"
	echo "Currency: $CURRENCY"
	echo ""
	printf 'Contact Name: '
	read -r CONTACT_NAME
		if [ "$CONTACT_NAME" = "" ]
		then
			CONTACT_NAME=$ACCOUNT_NAME
		else
			:
		fi
	CONTACT_NAME=`echo "$CONTACT_NAME" | sed "s/ /%20/"`
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
		fi
else
	echo "${red}Invalid Account${reset}" 1>&2
	add_contact
fi
}
################################################################################################

################################################################################################
delete_contact(){
	printf "Enter Contact ID: "
	read -r CONATACT_ID
	DELETESUCCESS=$(curl -s -b $COOKIE $BML_URL/contacts/$CONATACT_ID \
		--data-raw _method=delete \
		--compressed \
		| jq -r .code)

	if [ "$DELETESUCCESS" = "0" ]
	then
		echo Contact Deleted
		contacts_menu
	else
		echo "${red}There was an error${reset}"
		delete_contact
	fi
}
################################################################################################

################################################################################################
main_menu(){
echo "Main Menu"
echo ""
echo "1 - Accounts"
echo "2 - Transfer"
echo "3 - Contacts"
echo "4 - Activities"
echo "5 - Services"
echo "6 - Settings"
echo ""
printf 'Please Input: '
read -r MENU

if [ "$MENU" = "1" ]
        then
	banner
	api_dashboard
	accounts #& animate "Fetching account details"
#	display_user_info
	accounts_menu
elif [ "$MENU" = "2" ]
        then
	banner
	transfer_menu
elif [ "$MENU" = "3" ] || [ "$MENU" = "contacts" ]
        then
	banner && api_contacts &&  list_contacts &&  contacts_menu
elif [ "$MENU" = "4" ]
        then
	echo "WIP"
        sleep 2
        source mainmenu.sh
	source activities.sh
elif [ "$MENU" = "5" ]
        then
        echo "WIP"
        sleep 2
        source mainmenu.sh
	source services.sh
elif [ "$MENU" = "6" ]
	then
	banner && settings
elif [ "$MENU" = "clear" ]
	then
	clear
	sleep 0.2
	source mainmenu.sh
elif [ "$MENU" = "exit" ]
	then
	echo "cleaning up..."
	rm $COOKIE
	sleep 0.2
	exit
else
	banner
	echo ${red}Invalid input:${yellow} $MENU ${reset} 1>&2
        main_menu
fi
}
##############################################################################################
accounts_menu(){
	echo "Work In Progress"
	read -p "Press Anykey to go main menu" BRUH
	banner && display_welcome && display_user_info && main_menu
}
################################################################################################
contacts_menu(){
	echo "Contacts"
	echo ""
	echo "1 - Transfer"
	echo "2 - Add New Contact"
	echo "3 - Delete Contact"
	echo "x - Go back"
	echo ""
	printf 'Please Input: '
read -r CONTACTS

if [ "$CONTACTS" = "1" ]
then
	banner
	transfer_menu
elif [ "$CONTACTS" = "2" ]
then
	banner
	add_contact
	contacts_menu
elif [ "$CONTACTS" = "3" ]
then
	banner
	list_contacts
	delete_contact
	api_contacts
	contact_menu
elif [ "$CONTACTS" = "x" ] || [ "$CONTACTS" = "back" ]
then
	sleep 0.2
	banner
	main_menu
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
}
transfer_menu(){
	echo "Work In Progress"
	read -p "Press Anykey to go main menu" BRUH
	banner && display_user_info && main_menu
}

################################################################################################
settings(){
	echo "Settings"
	echo ""
	echo "1 - bml-cli Settings"
	echo "2 - BML Account Settings"
	echo "3 - Go Back"
	echo ""
	printf 'Please Input: '
	read -r SETTINGS

	if [ "$SETTINGS" = "1" ]
	then
		banner && bml-cli_settings
	elif [ "$SETTINGS" = "2" ]
	then
		source changepassword.sh
	elif [ "$SETTINGS" = "x" ] || [ "$SETTINGS" = "back" ]
	then
		banner && main_menu
	else
		banner
		display_user_info
		echo ${red}Invalid input:${yellow} $SETTINGS ${reset} 1>&2
		settings
	fi
}
bml-cli_settings(){
	echo "bml-cli Settings"
	echo ""
	echo "1 - Logout"
	echo "2 - Logout and reset configration"
	echo "3 - Back"
	echo ""
	printf 'Please Input: '
	read -r BML_CLI_SETTINGS
	if [ "$BML_CLI_SETTINGS" = "1" ]
	then
		logout
		echo "Exit.."
		exit
	elif [ "$BML_CLI_SETTINGS" = "2" ]
	then
		reset_config && exit
	elif [ "$BML_CLI_SETTINGS" = "3" ]
	then
		banner && settings
	fi
}
if [ ! -f $CONFIG ]
then
	initialize
fi

init_login(){
	if [ "$BML_USERNAME" != "" ]  && [ "$BML_PASSWORD" != "" ]
	then
		readpin
	else
		enter_credentials
	fi
}
banner && check_connection & animate "Checking Internet Connection"
banner && os_detect & animate "Detecting Operating System"
source $CONFIG
source $CREDENTIALS
banner && init_login
userinfo
banner && display_welcome && display_user_info && main_menu
