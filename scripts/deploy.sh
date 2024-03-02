#!/bin/sh

rm -r deploy
tsc -p tsconfig.deploy.json

mkdir working

cp package.json working/package.json
cp package-lock.json working/package-lock.json
cd working || exit
npm i --omit=dev
cd ..

mv deploy working/src/
mv working deploy
