apt update -y
apt install -y nginx

mv /home/vagrant/nginx.conf /etc/nginx

service nginx restart
