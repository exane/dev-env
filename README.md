# Vagrantfile
Ubuntu trusty64 with preinstalled zsh, nvm, jsonpp and direnv.

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
