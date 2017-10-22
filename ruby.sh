#!/bin/bash

# Dependencies
sudo apt-get update -y

# sudo apt-get install -y \
#   libmysqlclient-dev\
#   g++\
#   libxslt-dev libxml2-dev\
#   libmagickwand-dev imagemagick

# Install RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -ksSL https://get.rvm.io | bash -s stable

echo "source ~/.rvm/scripts/rvm" >> ~/.zshrc

# echo "mkdir -p /work/.ruby/rubies/" >> ~/.zshrc
# echo "mkdir -p /work/.ruby/gems/" >> ~/.zshrc

# NEEDS TO WORK
# ln -s ~/.zshrc test

echo "mkdir -p /work/.rvm" >> ~/.zshrc

# rm -r ~/.rvm/rubies && ln -s /work/.ruby/rubies -T ~/.rvm/rubies
# rm -r ~/.rvm/gems && ln -s /work/.ruby/gems -T ~/.rvm/gems
source ~/.rvm/scripts/rvm

# rvm install ruby
# rvm use ruby --default


# install rbenv
# sudo apt-get update -y
# sudo apt-get install -y g++ make bzip2
# git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# cd ~/.rbenv && src/configure && make -C src
# echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
# echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc

# # ruby-build
# mkdir -p "$(~/.rbenv/bin/rbenv root)/plugins"
# git clone https://github.com/rbenv/ruby-build.git "$(~/.rbenv/bin/rbenv root)"/plugins/ruby-build
