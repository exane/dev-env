#!/bin/bash
set -eu
source "/tmp/_helper.sh"

wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb 
sudo dpkg -i erlang-solutions_1.0_all.deb
rm erlang-solutions_1.0_all.deb

sudo apt-get update -y
sudo apt-get install -y esl-erlang elixir

# still waiting for inotify support in docker...
# sudo apt-get install inotify-tools

# install hex package manager
mix local.hex --force

# add installer for phoenix framework
# echo 'alias create-phoenix-app="mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez"' >> ~/.zshrc

# install phoenix framework

make_persistant ".mix"
config "if [ ! -d ~/.mix/archives/phx_new ]; then"
config "  mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force"
config "fi"

# warning: the VM is running with native name encoding of latin1 which may cause Elixir to malfunction as it expects utf8. Please ensure your locale is set to UTF-8 (which can be verified by running "locale" in your shell)
