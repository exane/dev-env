#!/bin/bash
set -eu
source "/tmp/_helper.sh"

# nvm install
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

make_persistant ".nvm"
# Workaround: nvm is not compatible with the npm config "prefix" option: currently set to [...]
config "export NVM_DIR=/store/.nvm"
config "nvm use default"

# yarn install
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

sudo apt-get update -y && sudo apt-get install yarn -y

make_persistant ".config"
config "export PATH=$PATH:~/.config/yarn/global/node_modules/.bin"
