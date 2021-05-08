curl -s -b $COOKIE $BML_URL/dashboard \
	| jq -r '.payload | .dashboard |.[] | (.alias, .account, .currency, .availableBalance)'

#	| jq -r '["Account Number","Currency","Balance"], (.["payload"] | .["dashboard"] | .[0] | [.account | .currency | .availableBalance]) | @csv'
#	["==================================================================="], \
#	(.["payload"] | .["dashboard"] | .["customer"] | .[0] | [.account | .currency | .availableBalance]) | @csv'


#	| jq -r payload.dashboard[0].availableBalance
#       | jq -r '(.["payload"] | .["dashboard"] | .["0"] | [.account | .currency | .availableBalance]) | @tsv'
source mainmenu.sh
