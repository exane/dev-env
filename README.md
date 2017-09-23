# Vagrantfile
Dev env

https://atlas.hashicorp.com/exane/boxes/ubuntu/

# Usage
```sh
vagrant init exane/ubuntu
vagrant up
```

or manually

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "exane/ubuntu"
  ...
```

```shell
vagrant package
vagrant box add exane/ubuntu ./package.box --force
```

# Databases

## Mysql (Mariadb)
Install:
```shell
docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mariadb
```

Client:
```shell
sudo apt install mysql-client
```

Usage:

```shell
mysql -h 192.168.99.100 -uroot
# or non-interactively
mysql -h 192.168.99.100 -uroot -proot
```

## Postgresql
Install:
```shell
docker run --name postgresql -p 5432:5432 -e POSTGRES_PASSWORD=root -e POSTGRES_USER=root -d postgres
```

Client:
```shell
sudo apt-get install postgresql-client-9.3
```

Usage:

```shell
psql -h 192.168.99.100 -Uroot
# or non-interactively
PGPASSWORD=root psql -h 192.168.99.100 -Uroot
```

## Mongodb
Install:
```shell
docker run --name mongodb -p 27017:27017 -d mongo
```

Client:
```shell
sudo apt-get install mongodb-clients
```

Usage:

```shell
mongo --host 192.168.99.100
# or non-interactively
mongo --host 192.168.99.100 -uroot -proot
```

## Elasticsearch
Install:
```shell
docker run --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -e ES_JAVA_OPTS="-Xms512m -Xmx512m" -d docker.elastic.co/elasticsearch/elasticsearch:5.6.1
```

Usage:

```shell
curl -uelastic:changeme http://192.168.99.100:9200
```
