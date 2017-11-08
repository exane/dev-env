wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
# echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.zshrc
# echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> $HOME/.zshrc
# echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> $HOME/.zshrc

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

# Loading nvm into the current console to be able to install the latest node version
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install node  # install latest node version

# install yarn globally
npm install -g yarn

touch ~/.yarnrc
# shared volumes do not comply with symlinks -> disable it
echo "--install.no-bin-links true" >> ~/.yarnrc
echo "--add.no-bin-links true" >> ~/.yarnrc
echo "--remove.no-bin-links true" >> ~/.yarnrc
echo "--upgrade.no-bin-links true" >> ~/.yarnrc
