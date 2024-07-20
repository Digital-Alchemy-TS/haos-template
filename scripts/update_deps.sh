#!/bin/bash
export PATH="./node_modules/figlet-cli/bin/:$PATH"

figlet -f "Pagga" "upgrade dependences" | npx lolcatjs
echo
yarn up "@digital-alchemy/*"
npx type-writer
