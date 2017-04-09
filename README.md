# Vagrantfile
Ubuntu trusty64 with preinstalled zsh, jsonpp and direnv.

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
