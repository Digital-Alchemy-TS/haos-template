#!/bin/bash

NC='\033[0m'
BOLD_PURPLE='\033[1;35m'

BACKUP_ARCHIVE="/backup/da_previous_deploy.tar.gz"
DEPLOY_ROOT="/share/digital_alchemy"
export PATH="./node_modules/figlet-cli/bin/:$PATH"

# 🪄
figlet -f "Elite" "Digital Alchemy" | npx lolcatjs
figlet -f "Pagga" "Create Deploy" | npx lolcatjs

# create or continue with no error
mkdir -p "$DEPLOY_ROOT"

# 1 version of backup history for quick rollback if things go wrong
echo -e "Creating archive of previous build at ${BOLD_PURPLE}$BACKUP_ARCHIVE${NC}"
rm "$BACKUP_ARCHIVE"
cd "$DEPLOY_ROOT" || exit
tar -czf "$BACKUP_ARCHIVE" .
cd - || exit

# create new code
npx tsc -p tsconfig.deploy.json

cp package.json "$DEPLOY_ROOT"
rm -rf "$DEPLOY_ROOT/node_modules" "$DEPLOY_ROOT/src" "$DEPLOY_ROOT/yarn.lock" "$DEPLOY_ROOT/package-lock.json"
mv ./deploy "$DEPLOY_ROOT/src"

figlet -f "Pagga" "Complete" | npx lolcatjs
