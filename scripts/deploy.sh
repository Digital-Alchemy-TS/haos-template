#!/bin/bash

NC='\033[0m'
BOLD_PURPLE='\033[1;35m'

export PATH="./node_modules/figlet-cli/bin/:$PATH"

figlet -f "Elite" "Digital Alchemy" | npx lolcatjs
figlet -f "Pagga" "Create Deploy" | npx lolcatjs

archive="./previous_deploy.tar.gz"

if [ -d "deploy" ]; then
  echo -e "Creating archive of previous build at ${BOLD_PURPLE}$archive${NC}"
  rm "$archive"
  tar -czf "$archive" ./deploy
else
  mkdir deploy
fi

# Create new code
npx tsc -p tsconfig.deploy.json
cp package.json ./deploy
cd ./deploy || exit
yarn


figlet -f "Pagga" "Complete" | npx lolcatjs
