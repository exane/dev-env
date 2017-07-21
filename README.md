# Vagrantfile
Ubuntu trusty64 with preinstalled docker, zsh, nvm, jsonpp and direnv.

https://atlas.hashicorp.com/exane/boxes/ubuntu_docker/

# Usage
```sh
vagrant init exane/ubuntu_docker
vagrant up
```

or manually

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "exane/ubuntu_docker"
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
