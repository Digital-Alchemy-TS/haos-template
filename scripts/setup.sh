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

prompt_yes_no() {
  while true; do
    read -p "$1 (yes/no)? " yn
    case $yn in
      [Yy]* ) result="yes"; break;;
      [Nn]* ) result="no"; break;;
      * ) echo "Please answer yes or no.";;
    esac
  done
  echo "$result"
}

update_config() {
  local key="$1"
  local new_value="$2"
  local file_path="$3"
  sed -i -E "/^[;[:space:]]*${key}[[:space:]]*=/c\\${key}=${new_value}" "$file_path"
}

# #MARK: Code Download
# * Check the path the script is being run on
# - If the script is being run from a subfolder of config, then we'll make some different assumptions
pattern="/config/*/scripts/setup.sh"
script_path=$(realpath "$0")

if [[ "$script_path" == "$pattern" ]]; then
  # * Script is being run from a subfolder
  # - This likely corresponds with a manual setup (like git clone)
  # Assume the rest of the directory structure currently exists
  echo -e "${BOLD_YELLOW}Skipping code setup${NC}"
else
  # * This script is being run from another configuration
  # - This is probably due to a download / execute of this script directly

  echo -e "${BOLD_GREEN}quick setup${NC}"
  default_folder_name="home_automation"

  # ? Prompt for where to put the code
  valid=0
  while [ $valid -eq 0 ]; do
    echo -e "Target folder (default: ${BLUE}${default_folder_name}${NC}): \c"
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

  # ? Download code and place in final destination
  wget -nv https://github.com/zoe-codez/automation-quickstart/archive/refs/heads/main.zip
  unzip -q main.zip

  # ! A surprise folder conflict appears!
  if [ -d "$folder_name" ]; then
    # - Update scripts/ folder?
    echo -e "${BOLD_YELLOW}Target already exists${NC}"
    echo -e "Update ${CYAN}scripts/${NC} \c"
    update_scripts=$(prompt_yes_no "")
    if [[ "$update_scripts" =~ "y" ]]; then
      cp automation-quickstart-main/scripts/* "$folder_name/scripts/"
    fi
    # cleanup and cd
    rm -r automation-quickstart-main
    rm main.zip
    cd "$folder_name" || exit
  else
    # ? New install
    mv automation-quickstart-main "$folder_name"

    # cleanup and cd
    rm main.zip
    cd "$folder_name" || exit

    # - customize some of the starting text based on the folder name
    if [ "$folder_name" != "$default_folder_name" ]; then
      new_name=$(basename "$folder_name")

      sed -i "s/home_automation/$new_name/g" package.json
      sed -i "s/home_automation/$new_name/g" automation.code-workspace
      sed -i "s/home_automation/$new_name/g" README.md
      sed -i "s/home_automation/$new_name/g" ./addon/config.yaml
      find ./src -type f -name "*.ts" -exec sed -i "s/home_automation/$new_name/g" {} \;
    fi
  fi
fi

# #MARK: Configure
echo -e "🔮 ${BOLD_PURPLE}auto configure from addon environment${NC} 🪄"
# - Setup Addon
zsh ./scripts/environment.sh "/config/$folder_name" --initial || exit 1

# - Setup Addon
export PATH="./node_modules/figlet-cli/bin/:/config/.fnm:$PATH"
eval "$(fnm env --shell=bash)"

echo
figlet -f "Pagga" "Addon" | npx lolcatjs
zsh ./scripts/addon.sh

# #MARK: Complete
echo
echo -e "${BOLD_GREEN}done!"
echo
figlet -f "Pagga" "Next Steps" | npx lolcatjs
echo
echo -e "${BOLD_YELLOW}1.${NC} ${BOLD}run this command${NC}"
echo -e "  ${BLUE}-${NC} ${CYAN}source ~/.zshenv${NC}"
echo
echo -e "${BOLD_YELLOW}2.${NC} ${BOLD}add init script to Studio Code Server${NC}"
echo -e "  ${BLUE}-${NC} add the following as an ${PURPLE}init_command${NC} in the ${BLUE}Configuration${NC} tab"
echo -e "  ${GRAY}/config/${folder_name}/scripts/init.sh${NC}"
echo
echo -e "${BOLD_YELLOW}3.${NC} ${BOLD}write your code${NC}"
echo -e "  ${BLUE}-${NC} ${CYAN}src/main.ts${NC} is the application entry point"
echo
echo -e "${BOLD_YELLOW}4.${NC} ${BOLD}run code${NC}"
echo -e "  ${BLUE}-${NC} see ${CYAN}package.json${NC} for listing of all options"
echo -e "  ${BLUE}-${NC} install the ${CYAN}Code Runner Addon${NC} to run in the background"
echo
figlet -f "Pagga" "Tips" | npx lolcatjs
echo
echo -e "  ${BLUE}-${NC} Get help on Discord ${BLUE}https://discord.gg/JkZ35Gv97Y${NC}"
echo -e "  ${BLUE}-${NC} Use the ${YELLOW}npx type-writer${NC} command to update types"
echo -e "  ${BLUE}-${NC} Create helper entities with the ${BLUE}synapse${NC} integration"
# syncthing

cd ..
rm setup.sh
