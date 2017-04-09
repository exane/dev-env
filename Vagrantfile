# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  ############################################################
  # Oh My ZSH Install section

  # Install git and zsh prerequisites 
  config.vm.provision :shell, inline: "add-apt-repository ppa:git-core/ppa -y"
  config.vm.provision :shell, inline: "apt-get update"
  config.vm.provision :shell, inline: "apt-get -y install git"
  config.vm.provision :shell, inline: "apt-get -y install zsh"

  # Clone Oh My Zsh from the git repo
  config.vm.provision :shell, privileged: false,
    inline: "git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh"

  # Copy in the default .zshrc config file
  config.vm.provision :shell, privileged: false,
    inline: "cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc"

  # Change the vagrant user's shell to use zsh
  config.vm.provision :shell, inline: "chsh -s /bin/zsh vagrant"

  ############################################################

  config.vm.provision :shell, inline: "echo 'stty sane' >> /home/vagrant/.zshrc"

  config.vm.provision "set startup directory",
    type: "shell", inline: "echo 'cd /vagrant' >> /home/vagrant/.zshrc"

  config.vm.provider "virtualbox" do |v|
    v.memory = 4000
    v.cpus = 4
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  # install jsonpp
  config.vm.provision "jsonpp", 
    type: "shell", 
    inline: <<-SHELL
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
      echo 'eval "$(direnv hook bash)"' >> /home/vagrant/.bashrc
  SHELL

  config.ssh.forward_agent = true
end
