#!/bin/sh

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
initanimate(){
	PID=$!
	h=0
	anim='⠋⠙⠴⠦'
	while [ -d /proc/$PID ]; do
	h=$(((h + 1) % 4))
	sleep 0.05
	printf "\r${@} [${anim:$h:1}]"
	done
	initbanner
}
animate(){
	PID=$!
	h=0
	anim='⠋⠙⠴⠦'
	while [ -d /proc/$PID ]; do
		h=$(((h + 1) % 4))
		sleep 0.05
	printf "\r${@} [${anim:$h:1}]"
	done
        banner
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
	if [ "$PING" != "0%" ] ; then
		echo ${red}Check your connection and try again.${reset}
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
}

initbanner(){
#	clear
	echo "${red}"
	echo "██████╗░███╗░░░███╗██╗░░░░░  ░█████╗░██╗░░░░░██╗"
	echo "██╔══██╗████╗░████║██║░░░░░  ██╔══██╗██║░░░░░██║"
	echo "██████╦╝██╔████╔██║██║░░░░░  ██║░░╚═╝██║░░░░░██║"
	echo "██╔══██╗██║╚██╔╝██║██║░░░░░  ██║░░██╗██║░░░░░██║"
	echo "██████╦╝██║░╚═╝░██║███████╗  ╚█████╔╝███████╗██║"
	echo "╚═════╝░╚═╝░░░░░╚═╝╚══════╝  ░╚════╝░╚══════╝╚═╝"
	echo "${reset}"
}

banner(){
#	clear
	echo "${red}"
	echo "██████╗░███╗░░░███╗██╗░░░░░  ░█████╗░██╗░░░░░██╗"
	echo "██╔══██╗████╗░████║██║░░░░░  ██╔══██╗██║░░░░░██║"
	echo "██████╦╝██╔████╔██║██║░░░░░  ██║░░╚═╝██║░░░░░██║"
	echo "██╔══██╗██║╚██╔╝██║██║░░░░░  ██║░░██╗██║░░░░░██║"
	echo "██████╦╝██║░╚═╝░██║███████╗  ╚█████╔╝███████╗██║"
	echo "╚═════╝░╚═╝░░░░░╚═╝╚══════╝  ░╚════╝░╚══════╝╚═╝"
	echo "${reset}"
	echo ${green}Welcome ${reset}$NAME
	echo ""
	echo ${cyan}Phone${reset}: $PHONE
	echo ${cyan}Email${reset}: $EMAIL
	echo ${cyan}Birthday${reset}: $DOB
	echo ${cyan}ID Card${reset}: $IDCARD
	echo ""
}

readpin(){
	read -s -p 'Enter Pin: ' PIN
	echo ""
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
	PIN=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
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
	echo ok
	#urandom & animate "${G}Randomzing Credentials${N}" && select_profile
}
login(){
	LOGIN=$(curl -s -c $COOKIE $BML_URL/login \
	--data-raw username=$BML_USERNAME_UNSAFE \
	--data-raw password=${BML_PASSWORD_UNSAFE} \
		| jq -r .code)
	if [ "$LOGIN" = "0" ]
        then
		echo Login success
		savepass
	elif [ "$LOGIN" = "20" ]
	then
		account_locked
	elif [ "$LOGIN" = "2" ]
	then
		echo Password or Username Incorrect
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
account_locked(){
	echo "${red}Account Locked!${reset}"
	echo "${lightred}Please reset password and login again.${reset}"
	echo ""
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
	enter_credentials
}

enter_credentials(){
	#echo ""
	read -p 'Username: ' BML_USERNAME_UNSAFE
	read -s -p 'Password: ' BML_PASSWORD_UNSAFE
	echo ""
	login
}

select_profile(){
REQPRO=$(curl -s -b $COOKIE $BML_URL/profile)
PERSONALPROFILE=$(echo $REQPRO \
	| jq -r '.payload | .profile | .[] | .profile' \
	| head -n 1)
curl -s -b $COOKIE $BML_URL/profile \
	--data-raw profile=$PERSONALPROFILE \
	--compressed > /dev/null
}

userinfo(){
USERINFO=$(curl -s -b $COOKIE $BML_URL/userinfo | jq -r '.["payload"] | .["user"]')
NAME=$(echo $USERINFO | jq -r .fullname)
PHONE=$(echo $USERINFO | jq -r .mobile_phone)
EMAIL=$(echo $USERINFO | jq -r .email)
DOB=$(echo $USERINFO | jq -r .birthdate |cut -d 'T' -f 1)
IDCARD=$(echo $USERINFO | jq -r .idcard)
}
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
	echo "WIP"
	sleep 2
	#source mainmenu.sh
	source accounts.sh
elif [ "$MENU" = "2" ]
        then
	echo "WIP"
        sleep 2
        source mainmenu.sh
	#source transfer.sh
elif [ "$MENU" = "3" ]
        then
	source contactsmenu.sh
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
	echo ${red}Invalid input:${yellow} $MENU ${reset} 1>&2
        source mainmenu.sh
fi
}

settings(){
	echo ""
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
		logout
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
}
bml-cli_settings(){
	echo ""
	echo "bml-cli Settings"
	echo ""
	echo "1 - Logout"
	echo "2 - Logout and reset configration"
	echo "3 - Exit"
	echo ""
	printf 'Please Input: '
	read -r BML-CLI_SETTINGS
	if [ "$BML-CLI_SETTINGS" = "1" ]
	then
		logout
		echo "Exit.."
		exit
	elif [ "$BML-CLI_SETTINGS" = "2" ]
	then
		reset_config && exit
	elif [ "$BML-CLI_SETTINGS" = "3" ]
	then
		exit
	fi
}
if [ ! -f $CONFIG ]
then
	initialize
fi

check_connection #& initanimate "Checking Internet Connection"
os_detect # & initanimate "Detecting Operating System"
source $CONFIG
source $CREDENTIALS
if [ "$BML_USERNAME" != "" ]  && [ "$BML_PASSWORD" != "" ]
then
	readpin
else
	enter_credentials
fi
#userinfo
#banner && main_menu
