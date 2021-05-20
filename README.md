# BML-CLI
## Bank Of Maldivces CLI client written in Bash. 
![photo_2021-04-28_14-59-35](https://user-images.githubusercontent.com/18140039/116385581-5c948300-a832-11eb-899b-9133501a4ae7.jpg)
This project is currently under development and a lot of things are broken.


## Getting Started
### Requirements
`curl` `jq` `openssl` `perl`
- Termux users will need `ncurses-utils` additionally for terminal colors
- Install with whatever package manager you use.
- Make SURE all requirements are met before running script.

#### Installation - GIT (Recommended)
```
git clone https://github.com/shihaamabr/bml-cli
cd bml-cli
chmod +x bml.sh
./bml.sh
```
#### Installation - Systemwide (NOT Recommended, May not work on some distros)
```
curl -sSL https://install.bml-cli.shihaam.dev | sudo bash
```

## Bugs
- Throw unknown error when wrong pin entered
- [You tell me :)](https://github.com/shihaamabr/bml-cli/issues/new)
