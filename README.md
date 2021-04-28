# Bank of Maldives CLI
BML CLI written in Bash. This project is currently under development and a lot of things are broken.

![photo_2021-04-28_14-36-47](https://user-images.githubusercontent.com/18140039/116382279-2dc8dd80-a82f-11eb-97ea-a864016cc032.jpg)


## Requiments 
`curl` `jq`

### Ubuntu
`sudo apt install curl jq`

### Fedora
`sudo dnf  install curl jq`

### Arch
`sudo pacman -S curl jq`

## Bugs
- Colored texts do not work in Termux
- Do **NOT** save passwords that contain one of the following characters
` | ^ $ & ; : ( )`

## Installation

### Recommended
```
git clone https://github.com/shihaamabr/bml-cli

cd bml-cli

chmod +x bml.sh
./bml.sh
```

### Not Recommended
```
chmod +x install.sh
./install.sh
```
