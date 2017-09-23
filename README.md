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
