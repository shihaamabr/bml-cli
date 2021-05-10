#Requesting for User profile after login and regex to grap the Full name
REQPRO=$(curl -s -b $COOKIE $BML_URL/profile)
PERSONALPROFILE=$(echo $REQPRO \
	| jq -r '.payload | .profile | .[] | .profile' \
	| head -n 1)
curl -s -b $COOKIE $BML_URL/profile \
	--data-raw profile=$PERSONALPROFILE \
	--compressed > /dev/null

USERINFO=$(curl -s -b $COOKIE $BML_URL/userinfo \
	| jq -r '.["payload"] | .["user"]')

NAME=$(echo $USERINFO \
        | jq -r .fullname)
PHONE=$(echo $USERINFO \
        | jq -r .mobile_phone)
EMAIL=$(echo $USERINFO \
        | jq -r .email)
DOB=$(echo $USERINFO \
        | jq -r .birthdate \
        | cut -d 'T' -f 1)
IDCARD=$(echo $USERINFO \
        | jq -r .idcard)

#display a Welcome message with fullname
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
source mainmenu.sh
