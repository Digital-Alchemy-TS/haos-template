#!/bin/bash

# install fast node manager
curl -fsSL https://fnm.vercel.app/install | bash

# load
export PATH="/root/.local/share/fnm:$PATH"
eval "$(fnm env --shell=zsh)"

# replace the default load command with one that works better for ha os
sed -i 's|eval "`fnm env`"|eval "$(fnm env --shell=zsh)"|' ~/.zshrc

# add to zsh env to allow code server to access node properly
echo "export PATH=\"/root/.local/share/fnm:\$PATH\"" >> ~/.zshenv
echo "eval \"\$(fnm env --shell=zsh)\"" >> ~/.zshenv

# clone the template repo
git clone https://github.com/zoe-codez/automation-template ./digital_alchemy
cd ./digital_alchemy || exit

# install the correct nodejs version
fnm install

# install @digital-alchemy, and
npm install
