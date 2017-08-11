# Ruby dependencies
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update -y
sudo apt-get install -y software-properties-common
sudo apt-get install -y build-essential zlib1g-dev libreadline-dev libssl-dev libcurl4-openssl-dev
sudo apt-get install -y gcc-6 autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

# Install Rbenv
sudo rm -rf ~/.rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

# Try to compile dynamic bash extension to speed up rbenv. Don't worry if it fails; rbenv will still work normally
cd ~/.rbenv && src/configure && make -C src

RBENV_PATH='export PATH="$HOME/.rbenv/bin:$PATH"'

grep "$RBENV_PATH" ~/.zshrc
MISSING=$?
if [ $MISSING == 1 ] ; then
  echo "RBENV not added to path, adding now."
  echo $RBENV_PATH >> ~/.zshrc
else
  echo "RBENV already added to path, skipping now"
fi

# Run for shell-specific instructions on how to initialize rbenv to enable shims and autocompletion.
~/.rbenv/bin/rbenv init

# ruby-build (for "$ rbenv install")
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
