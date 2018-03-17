
# Dev-env

## Setup (Windows 7 / docker-machine only )
Put this into .zshrc to make docker available in your current terminal

```bash
: $(docker-machine env --shell dev 2> /dev/null)
eval $("/c/Program Files/Docker Toolbox/docker-machine.exe" env --shell dev 2> /dev/null)

alias docker-start=". /path/to/dev-env/bin/docker-start.sh"  # this alias will start docker-machine
```

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
cp config.yml.example config.yml  # and edit it
make
```

## Run image
```bash
# Starts a new docker dev container and mounts the current working dir
docker run --rm -v $(PWD):/work --volumes-from dev-store -it dev
```

## Run as docker dev
```bash
# put bin/docker-dev.sh into path
alias docker="docker-dev.sh docker $*"

# usage
docker dev # to run the image on the current dir
docker dev -p 3000:3000 # with docker run options
# or
docker dev -p 3000 # short for -p 3000:3000
docker dev -- /bin/bash # use -- to append arguments
# would equal to: $ docker run -it ... dev /bin/bash
```

# Databases

## Install services
```shell
docker setup mysql/postgres/mongodb/etc
```

or manually

## Mysql (Mariadb)
### Install:
```shell
docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mariadb
```

### Usage:

```shell
mysql -h dev.docker -uroot
# or non-interactively
mysql -h dev.docker -uroot -proot
```

## Postgresql
### Install:
```shell
docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=root -e POSTGRES_USER=root -d postgres
```

### Usage:

```shell
psql -h dev.docker -Uroot
# or non-interactively
PGPASSWORD=root psql -h dev.docker -Uroot
```

## Mongodb
### Install:
```shell
docker run --name mongodb -p 27017:27017 -d mongo
```

### Usage:

```shell
mongo --host dev.docker
# or non-interactively
mongo --host dev.docker -uroot -proot
```

## Elasticsearch
### Install:
```shell
docker run --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -e "ES_JAVA_OPTS=-Xms512m" -d docker.elastic.co/elasticsearch/elasticsearch:5.6.1
```

### Usage:

```shell
curl -uelastic:changeme http://dev.docker:9200
```

## Redis
### Install:
```shell
docker run --name redis -p 6379:6379 -d redis
```

### Usage:
```shell
redis-cli -h dev.docker
```
