#!/bin/bash
# Reset
NC='\033[0m' # No Color

# Regular Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'

# Bold
BOLD='\033[1m'
BOLD_GREEN='\033[1;32m'
BOLD_YELLOW='\033[1;33m'
BOLD_BLUE='\033[1;34m'
BOLD_PURPLE='\033[1;35m'

echo -e "${BLUE}"
echo "░█▀▄░▀█▀░█▀▀░▀█▀░▀█▀░█▀█░█░░░░░█▀█░█░░░█▀▀░█░█░█▀▀░█▄█░█░█"
echo "░█░█░░█░░█░█░░█░░░█░░█▀█░█░░░░░█▀█░█░░░█░░░█▀█░█▀▀░█░█░░█░"
echo "░▀▀░░▀▀▀░▀▀▀░▀▀▀░░▀░░▀░▀░▀▀▀░░░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░░▀░"
echo -e "${NC}  ${BOLD_GREEN}quick setup"


read -r -p "Enter the folder name to build the project in (default: ./digital_alchemy): " folder_name
folder_name=${folder_name:-./digital_alchemy}

if [ ! -d "$folder_name" ]; then
  wget https://github.com/zoe-codez/automation-template/archive/refs/heads/main.zip
  unzip main.zip
  mv automation-template-main "$folder_name"
fi

echo
echo -e "${BOLD_GREEN}done!"
echo -e "${BLUE}"
echo "░█▀█░█▀▀░█░█░▀█▀░░░█▀▀░▀█▀░█▀▀░█▀█░█▀▀"
echo "░█░█░█▀▀░▄▀▄░░█░░░░▀▀█░░█░░█▀▀░█▀▀░▀▀█"
echo "░▀░▀░▀▀▀░▀░▀░░▀░░░░▀▀▀░░▀░░▀▀▀░▀░░░▀▀▀"
echo
echo
echo -e "${BOLD_YELLOW}1.${NC} ${BOLD}open the provided code workspace"
echo -e "  ${BLUE}-${NC} gain access to ${BLUE}tasks${NC} help maintain your setup"
echo -e "  ${BLUE}-${NC} open code-workspace in file explorer, click ${BOLD_BLUE}Open Workspace${NC} in ${PURPLE}bottom${NC}/${PURPLE}right"
echo -e "  ${BLUE}-${NC} open from cli: ${GREEN}code ${folder_name}/automation.code-workspace"
echo
echo -e "${BOLD_YELLOW}2.${NC} ${BOLD}configure files ${NC}${CYAN}.type_writer${NC}, ${CYAN}.home_automation"
echo -e "  ${BLUE}-${NC} provide with valid url to access instance with. default: ${CYAN}http://localhost:8123"
echo -e "  ${BLUE}-${NC} generate long lived access token, created from your user profile"
echo
echo -e "${BOLD_YELLOW}3.${NC} ${BOLD}set up nodejs ${BOLD_PURPLE}development${NC} ${BOLD}environment"
echo -e "  ${BLUE}-${NC} run script: ${GREEN}./scripts/environment.sh"
echo -e "  ${BLUE}-${NC} VSCode task '${BLUE}Environment Setup${NC}'"
echo
echo -e "${BOLD_YELLOW}4.${NC} ${BOLD}write your code"
echo -e "  ${BLUE}-${NC} some example code has been included to show patterns"
echo
echo -e "${BOLD_YELLOW}5.${NC} ${BOLD}validate code"
echo -e "  ${BLUE}-${NC} ${GREEN}npm run build"
echo -e "  ${BLUE}-${NC} VSCode task ${BLUE}Build${NC}"
echo
echo -e "${BLUE}"
echo "░█▀▄░█░█░█▀█"
echo "░█▀▄░█░█░█░█"
echo "░▀░▀░▀▀▀░▀░▀"
echo -e "${YELLOW}not intended for long term deployments!"
echo
echo -e "${BOLD_YELLOW}a.${NC} ${BOLD}run code${NC}"
echo -e "run a local instance of the automation code"
echo -e "  ${BLUE}-${NC} ${GREEN}npm run develop"
echo -e "  ${BLUE}-${NC} VSCode task ${BLUE}Stage${NC}"
echo
echo -e "${BOLD_YELLOW}b.${NC} ${BOLD}run in ${CYAN}watch${NC} mode"
echo -e "server will reload when files are saved"
echo -e "  ${BLUE}-${NC} ${GREEN}npm run develop:watch"
echo -e "  ${BLUE}-${NC} VSCode task ${BLUE}Develop${NC}"
echo
echo -e "${BLUE}"
echo "░█▀▄░█▀▀░█▀█░█░░░█▀█░█░█"
echo "░█░█░█▀▀░█▀▀░█░░░█░█░░█░"
echo "░▀▀░░▀▀▀░▀░░░▀▀▀░▀▀▀░░▀░"
echo -e "${NC}${GREEN}deploy code with automatic restart policies in place${NC}"
echo
echo -e "${BOLD_YELLOW}a${NC} ${BOLD}deploy${NC} ${BOLD_PURPLE}supervised${NC} ${BOLD}installation"
echo -e "requires the Synapse addon: ${CYAN}https://github.com/zoe-codez/synapse-addon"
echo -e "  ${BLUE}-${NC} ${GREEN}npm run deploy"
echo -e "  ${BLUE}-${NC} VSCode task ${BLUE}Deploy${NC}"
echo
echo -e "${BOLD_YELLOW}b${NC} ${BOLD}deploy${NC} ${BOLD_PURPLE}bare metal${NC} ${BOLD}installation${NC}"
echo -e "requires pm2: ${CYAN}https://www.npmjs.com/package/pm2"
echo -e "  ${BLUE}-${NC} ${GREEN}npm run deploy:pm2"
echo -e "  ${BLUE}-${NC} VSCode task ${BLUE}Deploy PM2${NC}"

# c whatever you want. nerd
