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
