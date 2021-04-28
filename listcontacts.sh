curl -s -b $COOKIE $BML_URL/contacts \
| jq -r '["ID","Account Number","Currency","Account Name","Contact Name"], ["==================================================================="], (.["payload"] | .[] | [.id, .account, .currency, .name, .alias]) | @tsv'
source contactsmenu.sh
