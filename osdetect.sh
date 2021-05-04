#!/bin/bash

if [ "uname -r | grep -oE microsoft" = "microsoft" ] || [ "uname -r | grep -oE Microsoft" = "Microsoft" ] || [ "uname -r | grep -oE icrosoft" = "icrosoft" ]
        then
		WSL=true
                #echo "${red}WSL Not Supported!${reset}" 1>&2
                #exit
elif [ "uname -a | grep -oE Darwin | tail -n1" = "Darwin" ]
        then
		MAC=true
                #echo "${red}MacOS Not Supported!${reset}" 1>&2
                #exit
elif [ "uname -a | grep -oE Android" = "Android" ]
	then
		ANDROID=true
else
                :
fi

source readpass.sh
