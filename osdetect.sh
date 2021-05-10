#!/bin/bash

if [ "uname -r | grep -oE microsoft" = "microsoft" ]
        then
		OS=windows
                #echo ${red}WSL Not Supported!${reset} 1>&2
                #exit
elif [ "uname -a | grep -oE Darwin | tail -n1" = "Darwin" ]
        then
		OS=macos
		export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
                #echo ${red}MacOS Not Supported!${reset} 1>&2
                #exit
elif [ "uname -a | grep -oE Android" = "Android" ]
	then
		OS=android
else
                :
fi

source readpass.sh
