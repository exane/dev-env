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

  # Install basics
  config.vm.provision "basics",
    type: :shell,
    inline: <<-SHELL
      add-apt-repository ppa:git-core/ppa -y
      apt-get update
      apt-get -y install git
    SHELL

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

  # install jsonpp
  config.vm.provision "jsonpp",
    type: "shell",
    inline: <<-SHELL
      apt update -y
      apt install unzip
      wget https://github.com/jmhodges/jsonpp/releases/download/1.3.0/jsonpp-1.3.0-linux-x86_64.zip
      unzip jsonpp-1.3.0-linux-x86_64.zip
      (cd jsonpp-1.3.0 && cp jsonpp /usr/bin/)
      rm -rf jsonpp-1.3.0 jsonpp-1.3.0-linux-x86_64.zip
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

  # install docker
  config.vm.provision "docker"

  # install nvm
  config.vm.provision "nvm",
    type: "shell",
    privileged: false,
    path: "./node.sh"

  # install php7
  config.vm.provision "php7",
    type: "shell",
    path: "./php7.sh"

  # install mysql (docker)
  config.vm.provision "mysql",
    type: "shell",
    inline: <<-SHELL
      docker pull mariadb
      docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mariadb

      apt-get update -y
      apt-get install -y mysql-client
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

  config.ssh.forward_agent = true
end
