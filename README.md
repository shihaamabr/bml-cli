# Bank of Maldives CLI
BML CLI written in Bash. This project is currently under development and a lot of things are broken.

![photo_2021-04-28_14-59-35](https://user-images.githubusercontent.com/18140039/116385581-5c948300-a832-11eb-899b-9133501a4ae7.jpg)
    
## Requirements
`curl` `jq` `openssl`
- Make sure all requirements are met before running script.
- Termux users will need `ncurses-utils` additionally for terminal colors

#### Arch Linux
`sudo pacman -S curl jq openssl`

#### Ubuntu
`sudo apt install curl jq openssl`

#### Fedora
`sudo dnf  install curl jq openssl`

### Termux
`pkg install curl jq openssl-tools ncurses-utils`

### OpenSUSE
`sudo zypper install curl jq openssl`

## Installation - git
```
git clone https://github.com/shihaamabr/bml-cli
cd bml-cli
chmod +x bml.sh
./bml.sh
```
## Installation systemwide - BETA
`curl -sSL https://install.bml-cli.shihaam.dev | sudo bash`



## Bugs
- Throws error and exists on MacOS and WSL \
  Solution run: `rm osdetect.sh`
