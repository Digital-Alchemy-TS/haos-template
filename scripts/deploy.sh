#!/bin/bash

NC='\033[0m'
BOLD_PURPLE='\033[1;35m'

BACKUP_ARCHIVE="/backup/da_previous_deploy.tar.gz"
DATA_ROOT="/data/digital_alchemy"
export PATH="./node_modules/figlet-cli/bin/:$PATH"

# 🪄
figlet -f "Elite" "Digital Alchemy" | npx lolcatjs
figlet -f "Pagga" "Create Deploy" | npx lolcatjs

# create or continue with no error
mkdir -p /data/digital_alchemy

# 1 version of backup history for quick rollback if things go wrong
echo -e "Creating archive of previous build at ${BOLD_PURPLE}$BACKUP_ARCHIVE${NC}"
rm "$BACKUP_ARCHIVE"
tar -czf "$BACKUP_ARCHIVE" "$DATA_ROOT"

# create new code
npx tsc -p tsconfig.deploy.json

# check for package updates
if cmp -s "./package.json" "$DATA_ROOT/package.json"; then
  echo -e "${BOLD_PURPLE}package.json${NC} has been updated, old ${BOLD_PURPLE}node_modules${NC}"
  cp package.json "$DATA_ROOT"
  rm -rf "$DATA_ROOT/node_modules" "$DATA_ROOT/yarn.lock" "$DATA_ROOT/package-lock.json"
fi

figlet -f "Pagga" "Complete" | npx lolcatjs
