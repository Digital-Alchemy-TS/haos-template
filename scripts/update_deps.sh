#!/bin/bash

if npx -v npx &> /dev/null
then
  npx figlet -f "Pagga" "upgrade npm" | npx lolcatjs
  echo
  npx ncu -u
  npm i
else
  npm i
fi

type-writer
