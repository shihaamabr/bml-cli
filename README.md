# Bank of Maldives CLI written in bash

## under dev, lots of things are broken.

### can you pr ascii art lmao 

- Requiments 
`curl` `jq` \
Make sure you have both of them installed \
`sudo apt install curl jq` on Ubuntu
### known bugs
- colored texts do not work in termux


### Use from source - Recommended
```
git clone https://github.com/shihaamabr/bmlcli

cd bmlcli/

chmod +x bml.sh
./bml.sh

```
### Installation - NOT Recommended (for now)
`curl -sL "https://raw.githubusercontent.com/shihaamabr/bmlcli/main/bml.sh" | sudo tee /usr/bin/bml-cli >/dev/null && sudo chmod 755 /usr/bin/bml-cli`

- Do NOT save password if password contain one of the following characters
` | ^ $ & ; : ( )`
