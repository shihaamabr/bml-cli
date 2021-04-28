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
echo ""
echo ${green}Welcome ${reset}$NAME
echo ""
echo Phone: $PHONE
echo Email: $EMAIL
echo Birthday: $DOB
echo ID Card: $IDCARD
echo ""
source mainmenu.sh
