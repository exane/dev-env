
# Dev-env
Dev env

## Create dev-store container
```bash
# used to store shared libs, such as rvm ruby versions
docker run -it --name dev-store -v /store -d busybox

# change store permissions to give write access
docker exec -it dev-store /bin/sh
chmod a+w -R /store
```

## Create docker image
```bash
# build with
make
```

## Run image
```bash
# run as
docker start dev-store # if not running

# Starts a new docker dev container and mounts the current working dir
docker run --rm -v $(PWD):/work --volumes-from dev-store -it dev
```

## (Experimental) Run as docker ssh
```bash
# put bin/docker-ssh.sh into path
alias docker="docker-ssh.sh docker $*"

# usage
docker ssh # to run the image on the current dir
docker ssh -p 3000:3000 # with docker run options
# or
docker ssh -p 3000 # short for -p 3000:3000
docker ssh -- /bin/bash # use -- to append arguments
# would equal to: $ docker run -it ... dev /bin/bash
```

# Databases

## Mysql (Mariadb)
### Install:
```shell
docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mariadb
```

### Usage:

```shell
mysql -h 192.168.99.100 -uroot
# or non-interactively
mysql -h 192.168.99.100 -uroot -proot
```

## Postgresql
### Install:
```shell
docker run --name postgresql -p 5432:5432 -e POSTGRES_PASSWORD=root -e POSTGRES_USER=root -d postgres
```

### Usage:

```shell
psql -h 192.168.99.100 -Uroot
# or non-interactively
PGPASSWORD=root psql -h 192.168.99.100 -Uroot
```

## Mongodb
### Install:
```shell
docker run --name mongodb -p 27017:27017 -d mongo
```

### Usage:

```shell
mongo --host 192.168.99.100
# or non-interactively
mongo --host 192.168.99.100 -uroot -proot
```

## Elasticsearch
### Install:
```shell
docker run --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -e ES_JAVA_OPTS="-Xms512m -Xmx512m" -d docker.elastic.co/elasticsearch/elasticsearch:5.6.1
```

### Usage:

```shell
curl -uelastic:changeme http://192.168.99.100:9200
```
