#Requesting for User profile after login and regex to grap the Full name
curl -s -b $COOKIE $BML_URL/profile > /dev/null

NAME=$(curl -s -b $COOKIE $BML_URL/userinfo \
	| jq -r '.["payload"] | .["user"] | .fullname')
PHONE=$(curl -s -b $COOKIE $BML_URL/userinfo \
	| jq -r '.["payload"] | .["user"] | .mobile_phone')
EMAIL=$(curl -s -b $COOKIE $BML_URL/userinfo \
	| jq -r '.["payload"] | .["user"] | .email')
DOB=$(curl -s -b $COOKIE $BML_URL/userinfo \
        | jq -r '.["payload"] | .["user"] | .birthdate')
#	| cut -f1 -d 'T' )
IDCARD=$(curl -s -b $COOKIE $BML_URL/userinfo \
        | jq -r '.["payload"] | .["user"] | .idcard')

#display a Welcome message with fullname
cat bml-logo.txt
#echo "${red}"
#echo "██████╗░███╗░░░███╗██╗░░░░░  ░█████╗░██╗░░░░░██╗"
#echo "██╔══██╗████╗░████║██║░░░░░  ██╔══██╗██║░░░░░██║"
#echo "██████╦╝██╔████╔██║██║░░░░░  ██║░░╚═╝██║░░░░░██║"
#echo "██╔══██╗██║╚██╔╝██║██║░░░░░  ██║░░██╗██║░░░░░██║"
#echo "██████╦╝██║░╚═╝░██║███████╗  ╚█████╔╝███████╗██║"
#echo "╚═════╝░╚═╝░░░░░╚═╝╚══════╝  ░╚════╝░╚══════╝╚═╝"
#echo "${reset}"
echo ${green}Welcome ${reset}$NAME
echo ""
echo ${cyan}Phone${reset}: $PHONE
echo ${cyan}Email${reset}: $EMAIL
echo ${cyan}Birthday${reset}: $DOB
echo ${cyan}ID Card${reset}: $IDCARD
echo ""
source mainmenu.sh
