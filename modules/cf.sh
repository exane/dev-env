#!/bin/bash
source /tmp/env.sh
wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list

sudo apt-get update -y
sudo apt-get install cf-cli

wget https://github.com/geofffranks/spruce/releases/download/v1.13.1/spruce-linux-amd64 -O $HOME/spruce
chmod +x $HOME/spruce

sudo install spruce /usr/bin

rm $HOME/spruce

script=$(cat <<-EOF
  if [ -f manifest.yml ] || [ -f manifest.yml.example ]; then
    cf api $CF_API;
    cf auth $CF_USER $CF_PASSWORD;
  fi;
EOF
)
echo $script >> ~/.zshrc
