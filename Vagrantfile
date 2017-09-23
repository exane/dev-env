# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
    v.memory = 4000
    v.cpus = 4
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  ############################################################
  # Oh My ZSH Install section

  config.vm.provision "git",
    type: "shell",
    path: "./git.sh"

  # Install zsh and clone Oh My Zsh from the git repo
  config.vm.provision "zsh",
    type: :shell,
    privileged: false,
    inline: <<-SHELL
      sudo apt-get update
      sudo apt-get -y install zsh
      sudo rm -rf ~/.oh-my-zsh; git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
      cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
      sudo chsh -s /bin/zsh vagrant  # Change the vagrant user's shell to use zsh
      echo 'stty sane' >> /home/vagrant/.zshrc
      echo 'cd /vagrant' >> /home/vagrant/.zshrc
    SHELL

  ############################################################

  # install jq (json-pretty-print + manipulation helper)
  # usage: curl http://.../api.json | jq .
  config.vm.provision "jq",
    type: "shell",
    inline: <<-SHELL
      apt update -y
      apt install -y jq
  SHELL

  # install direnv
  config.vm.provision "direnv",
    type: "shell",
    inline: <<-SHELL
      wget https://bin.equinox.io/c/4Jbv9XAvTAU/direnv-stable-linux-amd64.tgz
      tar -xvzf direnv-stable-linux-amd64.tgz
      mv direnv /usr/bin
      rm direnv-stable-linux-amd64.tgz 
      echo 'eval "$(direnv hook zsh)"' >> /home/vagrant/.zshrc
  SHELL

  # install nvm
  config.vm.provision "nvm",
    type: "shell",
    privileged: false,
    path: "./node.sh"

  # install php7
  config.vm.provision "php7",
    type: "shell",
    path: "./php7.sh"

  # install mysql-client
  config.vm.provision "mysql",
    type: "shell",
    inline: <<-SHELL
      apt-get update -y
      apt-get install -y mysql-client
  SHELL

  # install postgres-client
  config.vm.provision "postgres",
    type: "shell",
    inline: <<-SHELL
      apt-get update -y
      apt-get install -y postgresql-client-9.3
  SHELL

  # install mongodb-client
  config.vm.provision "mongodb",
    type: "shell",
    inline: <<-SHELL
      apt-get update -y
      apt-get install -y mongodb-clients
  SHELL

  # install ruby
  config.vm.provision "ruby",
    type: "shell",
    privileged: false,
    path: "./ruby.sh"

  # cleanup
  config.vm.provision "cleanup",
    type: "shell",
    inline: "apt-get autoremove -y"

  config.vm.provision "copy-gitconfig", type: "file", source: "~/.gitconfig", destination: "~/.gitconfig"
  config.vm.provision "copy-gitignore", type: "file", source: "~/.gitignore_global", destination: "~/.gitignore_global"
end
