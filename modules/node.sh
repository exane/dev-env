set -eu

# nvm install
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

nvm=$(cat <<-EOF
  if [ ! -d /store/nvm ]; then
    mkdir /store/nvm/;
    cp -r ~/.nvm/* /store/nvm;
  fi;
  rm -rf ~/.nvm;
  ln -s /store/nvm -T ~/.nvm;
  export NVM_DIR=/store/nvm;
  nvm use default;
EOF
)
echo $nvm >> ~/.zshrc

# yarn install
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

sudo apt-get update -y && sudo apt-get install yarn -y

yarn=$(cat <<-EOF
  if [ ! -d /store/config ]; then
    mkdir /store/config/;
    cp -r ~/.config/* /store/config;
  fi;
  rm -rf ~/.config;
  ln -s /store/config -T ~/.config;
  export PATH=$PATH:~/.config/yarn/global/node_modules/.bin
EOF
)
echo $yarn >> ~/.zshrc
