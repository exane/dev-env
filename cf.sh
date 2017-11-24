sudo apt-get update -y
sudo apt-get -y install apt-transport-https

wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
echo "deb http://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list

sudo apt-get update -y
sudo apt-get install cf-cli

wget https://github.com/geofffranks/spruce/releases/download/v1.13.1/spruce-linux-amd64 -O $HOME/spruce
chmod +x $HOME/spruce

sudo install spruce /usr/bin
