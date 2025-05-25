#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

TOTAL_OPERATIONS=0
SUCCESSFUL_OPERATIONS=0
FAILED_OPERATIONS=0

if [ ! -d "vscode-backup" ]; then
    echo -e "${RED}Error:${NC} vscode-backup folder not found!"
    exit 1
fi

echo -e "${YELLOW}Starting VSCode restore...${NC}"

# settings.json
TOTAL_OPERATIONS=$((TOTAL_OPERATIONS + 1))
if [ -f "./vscode-backup/settings.json" ]; then
    cp ./vscode-backup/settings.json ~/AppData/Roaming/Code/User/
    echo -e "${GREEN}✔${NC} Settings restored"
    SUCCESSFUL_OPERATIONS=$((SUCCESSFUL_OPERATIONS + 1))
else
    echo "Warning: settings.json not found"
    FAILED_OPERATIONS=$((FAILED_OPERATIONS + 1))
fi

# keybindings.json
TOTAL_OPERATIONS=$((TOTAL_OPERATIONS + 1))
if [ -f "./vscode-backup/keybindings.json" ]; then
    cp ./vscode-backup/keybindings.json ~/AppData/Roaming/Code/User/
    echo -e "${GREEN}✔${NC} Keybindings restored"
    SUCCESSFUL_OPERATIONS=$((SUCCESSFUL_OPERATIONS + 1))
else
    echo -e "${YELLOW}Warning:${NC} keybindings.json not found"
    FAILED_OPERATIONS=$((FAILED_OPERATIONS + 1))
fi

# snippets
TOTAL_OPERATIONS=$((TOTAL_OPERATIONS + 1))
if [ -d "./vscode-backup/snippets" ]; then
    cp -r ./vscode-backup/snippets ~/AppData/Roaming/Code/User/
    echo -e "${GREEN}✔${NC} Snippets restored"
    SUCCESSFUL_OPERATIONS=$((SUCCESSFUL_OPERATIONS + 1))
else
    echo -e "${YELLOW}Warning:${NC} snippets folder not found"
    FAILED_OPERATIONS=$((FAILED_OPERATIONS + 1))
fi

# git-prompt.sh
TOTAL_OPERATIONS=$((TOTAL_OPERATIONS + 1))
if [ -f "./vscode-backup/git-prompt.sh" ]; then
    cp ./vscode-backup/git-prompt.sh "C:/Program Files/Git/etc/profile.d/"
    echo -e "${GREEN}✔${NC} Git prompt restored"
    SUCCESSFUL_OPERATIONS=$((SUCCESSFUL_OPERATIONS + 1))
else
    echo -e "${YELLOW}Warning:${NC} git-prompt.sh not found"
    FAILED_OPERATIONS=$((FAILED_OPERATIONS + 1))
fi

# extensions
if [ -f "./vscode-backup/extensions.txt" ]; then
    while IFS= read -r extension; do
        TOTAL_OPERATIONS=$((TOTAL_OPERATIONS + 1))

        # Remove leading and trailing whitespace
        extension=$(echo "$extension" | xargs)
        
        # Check if the line is not empty and does not start with a comment
        if [ ! -z "$extension" ] && [[ ! "$extension" =~ ^#.* ]]; then
            
            # Check if the extension format is valid
            # Valid format: publisher.extension-name
            if [[ "$extension" =~ ^[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+$ ]]; then
                code --install-extension "$extension"
                if [ $? -eq 0 ]; then
                    echo -e "${GREEN}✔${NC} Successfully installed: $extension"
                    SUCCESSFUL_OPERATIONS=$((SUCCESSFUL_OPERATIONS + 1))
                else
                    echo -e "${RED}✗${NC} Failed to install: $extension"
                    FAILED_OPERATIONS=$((FAILED_OPERATIONS + 1))
                fi
            else
                echo -e "${RED}✗${NC} Invalid extension format: $extension (should be publisher.extension-name)"
                FAILED_OPERATIONS=$((FAILED_OPERATIONS + 1))
            fi
        fi
    done < "./vscode-backup/extensions.txt"
    echo -e "${GREEN}✔${NC} Extensions installation completed"
else
    echo -e "${YELLOW}Warning:${NC} extensions.txt not found"
fi

echo -e "${YELLOW}\nRestore completed! ${SUCCESSFUL_OPERATIONS}/${TOTAL_OPERATIONS}"
echo -e "Please restart VSCode to apply all changes.\n${NC}"