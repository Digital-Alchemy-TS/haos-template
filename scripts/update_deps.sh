#!/bin/bash
export PATH="./node_modules/figlet-cli/bin/:$PATH"

if command -v npx &> /dev/null
then
  figlet -f "Pagga" "upgrade dependences" | npx lolcatjs
  echo
  yarn up "@digital-alchemy/*"
else
  yarn install
fi

npx type-writer
