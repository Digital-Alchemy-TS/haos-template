#!/bin/bash
# Reset
NC='\033[0m' # No Color

# Regular Colors
RED='\033[0;31m'
GREEN='\033[0;32m'

# Bold
BOLD_RED='\033[1;31m'
BOLD_YELLOW='\033[1;33m'
BOLD_BLUE='\033[1;34m'
BOLD_PURPLE='\033[1;35m'
BOLD_CYAN='\033[1;36m'

FNM_INSTALL_PATH="/config/.fnm"
export PATH="./node_modules/figlet-cli/bin/:$FNM_INSTALL_PATH:$PATH"

echo -e "${BOLD_GREEN}quick setup${NC}"
default_folder_name="home_automation"

cd /config || exit 1

valid=0
while [ $valid -eq 0 ]; do
  echo -e "Install target (default: ${BLUE}${default_folder_name}${NC}): \c"
  read -r -p "" folder_name
  folder_name=${folder_name:-"$default_folder_name"}
  folder_name=${folder_name//[-]/_}

  # Check if the folder name starts with a letter or underscore and contains only letters, numbers, or underscores
  if [[ $folder_name =~ ^[a-zA-Z_]+[a-zA-Z0-9_]*$ ]]; then
    valid=1
  else
    echo "The folder name must start with a letter or underscore and contain only letters, numbers, or underscores."
    echo "Please enter a valid folder name."
  fi
done

wget -nv https://github.com/Digital-Alchemy-TS/haos-template/archive/refs/heads/main.zip
unzip -q main.zip
# Either set up a new workspace, or update scripts/ based on repo
if [ -d "$folder_name" ]; then
  echo -e "${BOLD_YELLOW}Target already exists, aborting${NC}"
  exit
else
  mv haos-template-main "$folder_name"
fi
rm main.zip

cd "$folder_name" || exit


# Customize the code based on the folder name!
# Variable replacements in code
if [ "$folder_name" != "$default_folder_name" ]; then
  new_name=$(basename "$folder_name")

  sed -i "s/home_automation/$new_name/g" package.json
  sed -i "s/home_automation/$new_name/g" automation.code-workspace
  sed -i "s/home_automation/$new_name/g" README.md
  sed -i "s/home_automation/$new_name/g" ./addon/config.yaml
  find ./src -type f -name "*.ts" -exec sed -i "s/home_automation/$new_name/g" {} \;
fi

echo -e "${BOLD_YELLOW}1.${NC} checking ${BOLD_CYAN}fnm${NC}"
# cannot find fnm command
if ! command -v fnm &>/dev/null; then
  # install if not exists
  if [ ! -d "$FNM_INSTALL_PATH" ]; then
    echo -e "${BOLD_PURPLE}fnm${NC} could not be found, installing..."
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$FNM_INSTALL_PATH" --skip-shell
  fi

  # import into local session
  echo -e "loading ${BOLD_PURPLE}fnm${NC}"
  eval "$(fnm env --shell=bash)"
else
  echo -e "${GREEN}already loaded${NC}"
  eval "$(fnm env --shell=bash)"
fi

echo
echo -e "${BOLD_YELLOW}2.${NC} checking ${BOLD_CYAN}zshenv${NC}"
if [ ! -f ~/.zshenv ] || ! grep -q "fnm env" ~/.zshenv; then
  echo -e "writing changes to ${GREEN}~/.zshenv${NC}"
  echo "export PATH=\"$FNM_INSTALL_PATH:\$PATH\"" >>~/.zshenv
  echo "eval \"\$(fnm env --shell=zsh)\"" >>~/.zshenv
else
  echo -e "${GREEN}already configured${NC}"
fi

echo
echo -e "${BOLD_YELLOW}3.${NC} checking ${BOLD_CYAN}node${NC}"
if ! node -v node &>/dev/null; then
  echo -e "${BOLD_PURPLE}node${NC} could not be found, installing..."
  fnm install 20
  fnm default 20
else
  echo -e "${GREEN}already installed${NC}"
fi

echo
echo -e "${BOLD_YELLOW}4.${NC} verifying ${BOLD_CYAN}node_modules${NC}"
corepack enable && corepack prepare yarn@stable --activate

yarn install
yarn up "@digital-alchemy/*"
rm -rf node_modules yarn.lock
yarn install

echo -e "${GREEN}done${NC}"

echo
echo -e "${BOLD_YELLOW}6.${NC} rebuilding ${BOLD_CYAN}custom definitions${NC}"
npx type-writer

echo
cd ..
rm setup.sh

echo
echo -e "${BOLD_YELLOW}0.${NC} ${BOLD}load nodejs for your current terminal"
echo -e "  ${BLUE}-${NC} ${BOLD_CYAN}source ~/.zshenv${NC}"
echo
echo -e "${BOLD_YELLOW}1.${NC} ${BOLD}write your code"
echo -e "  ${BLUE}-${NC} ${BOLD_CYAN}src/main.ts${NC} is the application entry point"
echo -e "  ${BLUE}-${NC} demonstration project included (has made up entities)"
echo
echo -e "${BOLD_YELLOW}2.${NC} ${BOLD}run dev server"
echo -e "  ${BLUE}-${NC} ${BOLD_CYAN}yarn start${NC}"
echo -e "  ${BLUE}-${NC} sends a hello world notification! (probably)"
echo
echo -e "${BOLD_YELLOW}3.${NC} configure ${BOLD}Code Server"
echo -e "  ${BLUE}-${NC} add ${BOLD_CYAN}/config/${folder_name}/scripts/init.sh${NC} as an init_command"
echo -e "  ${BLUE}-${NC} ensure your workspace is immediately usable after reboots"
echo
echo -e "${BOLD_YELLOW}4.${NC} ${BOLD}install addon"
echo -e "  ${BLUE}-${NC} install the Code Runner addon to run your stable builds in the background"
echo
echo -e "${BOLD_YELLOW}5.${NC} ${BOLD}install synapse-extension"
echo -e "  ${BLUE}-${NC} add the integration via HACS to generate helper entities"
echo
echo -e "${BOLD_YELLOW}6.${NC} ${BOLD}syncthing?"
echo -e "  ${BLUE}-${NC} use the syncthing addon to write code remotely with ease"
echo

exit 0
