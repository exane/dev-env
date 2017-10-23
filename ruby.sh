#!/bin/bash

# Dependencies
sudo apt-get update -y

sudo apt-get install -y \
  bzip2 g++ gcc make libc6-dev zlib1g-dev libyaml-dev libsqlite3-dev sqlite3 \
  autoconf libgmp-dev libgdbm-dev libncurses5-dev automake libtool bison pkg-config \
  libffi-dev libgmp-dev libreadline6-dev libssl-dev \
  libmysqlclient-dev \
  libxslt-dev libxml2-dev\
  libmagickwand-dev imagemagick

# Install RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable

rvm=$(cat <<-EOF
  if [ ! -d /store/rvm ]; then
    mkdir /store/rvm/;
    cp -r ~/.rvm/* /store/rvm;
  fi;
  rm -rf ~/.rvm;
  ln -s /store/rvm -T ~/.rvm;
EOF
)
echo $rvm >> ~/.zshrc
echo "source ~/.rvm/scripts/rvm" >> ~/.zshrc
