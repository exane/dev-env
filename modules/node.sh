#!/bin/bash
set -eu
source "/tmp/_helper.sh"

# nvm install
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

make_persistant ".nvm"
# Workaround: nvm is not compatible with the npm config "prefix" option: currently set to [...]
config "export NVM_DIR=/store/.nvm"
config "nvm alias default 8 > /dev/null"
config "nvm use default"

# yarn install
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

# yarn v1.9.2 linker is incredibly slow (10 minutes linking..)
# https://github.com/yarnpkg/yarn/issues/6177
sudo apt-get update -y && sudo apt-get install yarn=1.7.0-1 -y

make_persistant ".config"
add_path "~/.config/yarn/global/node_modules/.bin"
