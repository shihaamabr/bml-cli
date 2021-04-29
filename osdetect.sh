#!/bin/bash

if [ "uname -r | grep -oE microsoft" = "microsoft" ]
        then
                echo "${red}WSL Not Supported!${reset}" 1>&2
                exit
elif [ "uname -a | grep -oE Darwin | tail -n1" = "Darwin" ]
        then
                echo "${red}MacOS Not Supported!${reset}" 1>&2
                exit
else
                :
fi

source readpass.sh
