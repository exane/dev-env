# Vagrantfile
Ubuntu trusty64 with preinstalled docker, zsh, jsonpp and direnv.

https://atlas.hashicorp.com/exane/boxes/ubuntu/

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
