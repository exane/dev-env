apt-add-repository ppa:ondrej/php -y
apt-get update -y
apt-get install -y php5-cgi phpunit  # Workaround for phpunit to not install apache2. https://bugs.launchpad.net/ubuntu/+source/phpunit/+bug/1315678
apt-get install -y php7.0-common php7.0-mysql php7.0-fpm php7.0-curl php7.0-gd php7.0-bz2 php7.0-mbstring php7.0-xml php7.0-sqlite 
apt-get install -y php7.1-common php7.1-mysql php7.1-fpm php7.1-curl php7.1-gd php7.1-bz2 php7.1-mbstring php7.1-xml php7.1-sqlite 

# install composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
