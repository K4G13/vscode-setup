#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

mkdir vscode-backup
cp ~/AppData/Roaming/Code/User/settings.json ./vscode-backup/
cp ~/AppData/Roaming/Code/User/keybindings.json ./vscode-backup/
cp -r ~/AppData/Roaming/Code/User/snippets ./vscode-backup/
cp C:/Program\ Files/Git/etc/profile.d/git-prompt.sh ./vscode-backup/
code --list-extensions > ./vscode-backup/extensions.txt
echo -e "${GREEN}✔${NC} Backup completed in vscode-backup folder"
