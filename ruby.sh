# Dependencies
sudo apt-get install -y \
  libmysqlclient-dev\
  g++\
  phantomjs\
  libxslt-dev libxml2-dev\
  libmagickwand-dev imagemagick

# Install RVM
curl -sSL https://get.rvm.io | bash -s stable

RVM_SCRIPT='source ~/.rvm/scripts/rvm"'

grep "$RVM_SCRIPT" ~/.zshrc
MISSING=$?
if [ $MISSING == 1 ] ; then
  echo "RVM script loading not added to zshrc, adding now."
  echo "source ~/.rvm/scripts/rvm" >> ~/.zshrc
else
  echo "RVM script loading already added to zshrc, skipping now"
fi
