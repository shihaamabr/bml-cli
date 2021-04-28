#Requesting for User profile after login and regex to grap the Full name
NAME=$(curl -s -b $COOKIE $BML_URL/profile \
                | awk -F 'fullname":"' '{print $2}' \
                | cut -f1 -d '"')

#display a Welcome message with fullname
echo ""
echo ${green}Welcome ${reset}$NAME
#curl -s -b $COOKIE $BML_URL/userinfo
echo ""
source mainmenu.sh
