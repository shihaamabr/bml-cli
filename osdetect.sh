#!/bin/bash
WSL1=$(uname -r | grep -oE Microsoft)
WSL2=$(uname -r | grep -oE microsoft)
MAC=$(uname -a | grep -oE Darwin | tail -n1)
ANDROID=$(uname -a | grep -oE Android)

if [ "$WSL1" = "Microsoft" ] || [ "$WSL2" = "microsoft" ]
        then
                OS=windows
                #echo ${red}WSL Not Supported!${reset} 1>&2
                #exit
elif [ "$MAC" = "Darwin" ]
        then
                OS=macos
                export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
                #echo ${red}MacOS Not Supported!${reset} 1>&2
                #exit
elif [ "$ANDROID" = "Android" ]
        then
                OS=android
else
                :
fi

source readpass.sh

