#!/bin/bash
NC='\033[0m' # No Color

# Regular Colors
YELLOW='\033[0;33m'
CYAN='\033[0;36m'

# Bold
BOLD_RED='\033[1;31m'
BOLD_BLUE='\033[1;34m'


figlet -f "Elite" "Digital Alchemy" | npx lolcatjs
figlet -f "Pagga" "Rollback Deploy" | npx lolcatjs

BACKUP_ARCHIVE="/backup/da_previous_deploy.tar.gz"
DATA_ROOT="/data/digital_alchemy"

if [ ! -f "$BACKUP_ARCHIVE" ]; then
  echo -e "${BOLD_RED}Cannot find ${BACKUP_ARCHIVE}${NC}"
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

if [ -d "$DATA_ROOT" ]; then
  echo -e "💣 Removing current deploy"
  rm -r $DATA_ROOT
fi

tar xzvf "$BACKUP_ARCHIVE"
echo "🥱"

figlet -f "Pagga" "Done" | npx lolcatjs
