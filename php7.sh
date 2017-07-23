apt-add-repository ppa:ondrej/php -y
apt-get update -y
apt-get install -y php5-cgi phpunit  # Workaround for phpunit to not install apache2. https://bugs.launchpad.net/ubuntu/+source/phpunit/+bug/1315678
apt-get install -y php7.0-common php7.0-mysql php7.0-fpm php7.0-curl php7.0-gd php7.0-bz2 php7.0-mbstring php7.0-xml php7.0-sqlite 
apt-get install -y php7.1-common php7.1-mysql php7.1-fpm php7.1-curl php7.1-gd php7.1-bz2 php7.1-mbstring php7.1-xml php7.1-sqlite 

# Setup php-fpm to listen to 9000
(
  cd /etc/php/7.1/fpm/pool.d/
  awk '{sub(/listen =.*/, "listen = 127.0.0.1:9000")}; 1' www.conf > tmp.www.conf
  mv tmp.www.conf www.conf
  service php7.1-fpm restart
)

# install composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
