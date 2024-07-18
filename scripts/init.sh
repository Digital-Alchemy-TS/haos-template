#!/bin/bash
# load already installed fnm
export PATH="/config/.fnm:$PATH"
eval "$(fnm env --shell=bash)"

# re-create zshenv
echo "export PATH=\"/config/.fnm:\$PATH\"" >> ~/.zshenv
echo "eval \"\$(fnm env --shell=zsh)\"" >> ~/.zshenv

# set up nodejs again
if ! node -v node &> /dev/null
then
  fnm install 20
  fnm default 20
fi

# load yarn
full=$(realpath "$0")
base=$(dirname "$full")
cd "$base/.." || exit
corepack enable
