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

  sed -i "/^\s*${key}\s*=/c\\${key}=${new_value}" "$file_path"
}

echo -e "${BOLD_GREEN}quick setup${NC}"
default_folder_name="home_automation"

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

wget -nv https://github.com/zoe-codez/automation-quickstart/archive/refs/heads/main.zip
unzip -q main.zip
# Either set up a new workspace, or update scripts/ based on repo
if [ -d "$folder_name" ]; then
  echo -e "${BOLD_YELLOW}Target already exists${NC}"
  echo -e "Update ${CYAN}scripts/${NC} \c"
  update_scripts=$(prompt_yes_no "")
  if [[ "$update_scripts" =~ "y" ]]; then
    cp automation-quickstart-main/scripts/* "$folder_name/scripts/"
  fi
  rm -r automation-quickstart-main
else
  mv automation-quickstart-main "$folder_name"
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

  # Rename .home_automation to .{new_name} if it exists
  if [ -f ".home_automation" ]; then
    mv .home_automation ".$new_name"
  fi
fi

if [[ -n "$HASSIO_TOKEN" || -n "$SUPERVISOR_TOKEN" ]]; then
    echo -e "🔮 ${BOLD_PURPLE}auto configure from addon environment${NC} 🪄"
    rm ".$new_name"
    rm .type_writer
    zsh ./scripts/environment.sh "/config/$folder_name" --initial || exit 1

    export PATH="./node_modules/figlet-cli/bin/:/config/.fnm:$PATH"
    eval "$(fnm env --shell=bash)"

    echo
    figlet -f "Pagga" "Addon" | npx lolcatjs
    zsh ./scripts/addon.sh
else
  create_conf=$(prompt_yes_no "Create configuration file")

  if [[ "$create_conf" =~ "y" ]]; then
    echo -e "Enter ${BOLD}BASE_URL${NC} (default: ${CYAN}http://homeassistant.local:8123${NC}): \c"
    read -r -p "" base_url
    base_url=${base_url:-http://homeassistant.local:8123}

    echo -e "Enter long ${BOLD}lived access token${NC}: "
    read -r -s token
    echo

    config_file=".$new_name"

    update_config "BASE_URL" "$base_url" "$config_file"
    update_config "TOKEN" "$token" "$config_file"
    update_config "BASE_URL" "$base_url" ".type_writer"
    update_config "TOKEN" "$token" ".type_writer"

  zsh ./scripts/environment.sh "./$folder_name" --initial || exit 1
  else
    echo "Skipping configuration file creation."
    zsh ./scripts/environment.sh "./$folder_name" --initial --quick || exit 1
  fi

  export PATH="./node_modules/figlet-cli/bin/:$HOME/.fnm:$PATH"
  eval "$(fnm env --shell=bash)"
  # todo: something with pm2 probably

fi

echo
echo -e "${BOLD_GREEN}done!"
echo
figlet -f "Pagga" "Next Steps" | npx lolcatjs
echo
echo -e "${BOLD_YELLOW}2.${NC} ${BOLD}write your code"
echo -e "  ${BLUE}-${NC} ${CYAN}src/main.ts${NC} is the application entry point"
echo
echo -e "${BOLD_YELLOW}3.${NC} ${BOLD}run code"
echo -e "  ${BLUE}-${NC} see ${CYAN}package.json${NC} for listing of all options"
echo

cd ..
rm setup.sh
