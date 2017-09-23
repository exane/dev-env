add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get -y install git git-flow

git clone git@github.com:avarteqgmbh/git_flow_hooks.git /home/vagrant/git_flow_hooks

git config --global gitflow.path.hooks /home/vagrant/git_flow_hooks/hooks
git config --global gitflow.prefix.versiontag v
