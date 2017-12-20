wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt-get update -y
sudo apt-get install -y esl-erlang elixir

sudo apt-get install inotify-tools

# install hex package manager
mix local.hex --force

# add installer for phoenix framework
# echo 'alias create-phoenix-app="mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez"' >> ~/.zshrc

# install phoenix framework

script=$(cat <<-EOF
  if [ ! -d /store/mix ]; then
    mkdir /store/mix/;
    cp -r ~/.mix/* /store/mix;
  fi;
  rm -rf ~/.mix;
  ln -s /store/mix -T ~/.mix;
  if [ ! -d ~/.mix/archives/phx_new ]; then
    mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force;
  fi;
EOF
)

echo $script >> ~/.zshrc

# warning: the VM is running with native name encoding of latin1 which may cause Elixir to malfunction as it expects utf8. Please ensure your locale is set to UTF-8 (which can be verified by running "locale" in your shell)
