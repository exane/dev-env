wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> $HOME/.zshrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> $HOME/.zshrc

# Loading nvm into the current console to be able to install the latest node version
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install node  # install latest node version

# install yarn globally
npm install -g yarn
