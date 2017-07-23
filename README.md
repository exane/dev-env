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
