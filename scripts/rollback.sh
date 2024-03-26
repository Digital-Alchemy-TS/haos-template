#!/bin/bash
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
BOLD_RED='\033[1;31m'
BOLD_YELLOW='\033[1;33m'
BOLD_BLUE='\033[1;34m'
BOLD_PURPLE='\033[1;35m'


figlet -f "Elite" "Digital Alchemy" | npx lolcatjs
figlet -f "Pagga" "Rollback Deploy" | npx lolcatjs

archive="./previous_deploy.tar.gz"

if [ ! -f "$archive" ]; then
  echo -e "${BOLD_RED}Cannot find ${archive}${NC}"
  exit 1
fi

echo -e "${BOLD_BLUE}This script will${NC}":
echo -e " ${YELLOW}-${NC} Remove the existing ${CYAN}deploy${CYAN} folder"
echo -e " ${YELLOW}-${NC} Restore the previous ${CYAN}deploy${CYAN} folder"

echo -e "In 5"
sleep 1
echo -e "${YELLOW}4${NC}"
sleep 1
echo -e "${YELLOW}3${NC}"
sleep 1
echo -e "${RED}2${NC}"
sleep 1
echo -e "${RED}1${NC}"
sleep 1

if [ -d "deploy" ]; then
  echo -e "💣 Removing current deploy"
  rm -r deploy
fi
tar xzvf "$archive"
echo "🥱"

figlet -f "Pagga" "Done" | npx lolcatjs
