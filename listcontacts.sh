curl -s -b $COOKIE $BML_URL/contacts \
| jq -r '["Account Number","Currency","Account Name","Contact Name"], ["==================================================================="], (.["payload"] | .[] | [.account, .currency, .name, .alias]) | @tsv'
source contactsmenu.sh
