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


if [[ -n "$HASSIO_TOKEN" || -n "$SUPERVISOR_TOKEN" ]]; then
  FNM_INSTALL_PATH="/config/.fnm"
else
  FNM_INSTALL_PATH="$HOME/.fnm"
fi

export PATH="./node_modules/figlet-cli/bin/:$FNM_INSTALL_PATH:$PATH"



echo -e "${BOLD_YELLOW}1.${NC} checking ${BOLD_CYAN}fnm${NC}"
# cannot find fnm command
if ! command -v fnm &> /dev/null
then
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
fi

echo
echo -e "${BOLD_YELLOW}2.${NC} checking ${BOLD_CYAN}zshenv${NC}"
if [ ! -f ~/.zshenv ] || ! grep -q "fnm env" ~/.zshenv; then
  echo -e "writing changes to ${GREEN}~/.zshenv${NC}"
  echo "export PATH=\"$FNM_INSTALL_PATH:\$PATH\"" >> ~/.zshenv
  echo "eval \"\$(fnm env --shell=zsh)\"" >> ~/.zshenv
else
  echo -e "${GREEN}already configured${NC}"
fi

echo
echo -e "${BOLD_YELLOW}3.${NC} checking ${BOLD_CYAN}node${NC}"
if ! node -v node &> /dev/null
then
  echo -e "${BOLD_PURPLE}node${NC} could not be found, installing..."
  fnm install 20
  fnm default 20
else
  echo -e "${GREEN}already installed${NC}"
fi

echo
echo -e "${BOLD_YELLOW}4.${NC} verifying ${BOLD_CYAN}node_modules${NC}"
npm install > /dev/null

for arg in "$@"
do
  if [ "$arg" = "--initial" ]; then
    npx ncu -u
    npm install > /dev/null
  fi
done

echo -e "${GREEN}done${NC}"


for arg in "$@"
do
  if [ "$arg" = "--quick" ]; then
    figlet -f "Pagga" "Success" | npx lolcatjs
    exit 0
  fi
done


echo
echo -e "${BOLD_YELLOW}5.${NC} checking ${BOLD_CYAN}type-writer${NC} credentials"
# pass a flag to the `hass` library asking it to validate credentials then quit.
# overrides default functionality
output=$(npx type-writer --validate_configuration 2>&1)

# Check the output for specific patterns indicating success or failure
if echo "$output" | grep -q "401: Unauthorized"; then
  echo -e "${RED}"
  figlet -f "Pagga" "Error"
  echo -e "${NC}"
  echo -e "Invalid ${BOLD_RED}TOKEN${NC}"
  exit 1
elif echo "$output" | grep -q "API running"; then
  echo -e "${GREEN}valid${NC}"
else
  echo -e "${RED}"
  figlet -f "Pagga" "Error"
  echo -e "${NC}"
  echo -e "invalid ${BOLD_RED}BASE_URL${NC} - ${BOLD_BLUE}script output${NC}"
  echo
  echo -e "${output}"
  exit 1
fi

echo
echo -e "${BOLD_YELLOW}6.${NC} rebuilding ${BOLD_CYAN}custom definitions${NC}"
npx type-writer
echo
figlet -f "Pagga" "Success" | npx lolcatjs
exit 0
