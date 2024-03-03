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
  # Remove the existing deploy
  rm -r deploy
fi


# Create structure
# /deploy
# /deploy/src/{code}
# /deploy/package.json
# /deploy/node_modules
mkdir working
cd working || exit
cp ../package.json ../package-lock.json .
# production dependencies only
npm i --omit=dev
cd ..

# Create new code
npx tsc -p tsconfig.deploy.json

# Final assembly
mv deploy working/src/
mv working deploy

figlet -f "Pagga" "Complete" | npx lolcatjs
