# sudo apt-get install -y python-software-properties
LC_ALL=C.UTF-8 sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update -y
# sudo apt-get install -y php5-cgi phpunit  # Workaround for phpunit to not install apache2. https://bugs.launchpad.net/ubuntu/+source/phpunit/+bug/1315678
# sudo apt-get install -y php7.0-common php7.0-mysql php7.0-fpm php7.0-curl php7.0-gd php7.0-bz2 php7.0-mbstring php7.0-xml php7.0-sqlite 
sudo apt-get install -y php7.1-common php7.1-mysql php7.1-fpm php7.1-curl php7.1-gd php7.1-bz2 php7.1-mbstring php7.1-xml php7.1-sqlite php7.1-zip

# install composer
sudo chmod a+w /usr/local/bin
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
