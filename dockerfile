# serve ~ under 192.168.99.1:8080
# $ ruby -run -ehttpd ~ -p8080 -b192.168.99.1
FROM ubuntu:xenial

ENV SERVE_HTTP_ADDRESS 192.168.99.1
ENV SERVE_HTTP_PORT 8080
ENV USER dev

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y vim sudo software-properties-common python-software-properties apt-utils \
    && apt-get autoremove -y

RUN apt-get update \
    && apt-get install -y manpages manpages-dev freebsd-manpages funny-manpages man2html manpages-posix manpages-posix-dev \
    && apt-get autoremove -y

RUN apt-get update \
    && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && apt-get autoremove -y
ENV LANG en_US.utf8

RUN useradd -m $USER && echo "$USER:$USER" | chpasswd && adduser $USER sudo

# SSH config
RUN apt-get update\
    && apt-get install -y openssh-client \
    && apt-get autoremove -y
ADD ssh_config /etc/ssh/ssh_config
ADD http://$SERVE_HTTP_ADDRESS:$SERVE_HTTP_PORT/.ssh/id_rsa /home/$USER/.ssh/id_rsa

# GIT config
ADD http://$SERVE_HTTP_ADDRESS:$SERVE_HTTP_PORT/.gitconfig /home/$USER/.gitconfig
ADD http://$SERVE_HTTP_ADDRESS:$SERVE_HTTP_PORT/.gitignore_global /home/$USER/.gitignore_global
RUN apt-get update \
    && apt-get -y install git git-flow \
    && eval $(ssh-agent -s) \
    && ssh-add /home/$USER/.ssh/id_rsa \
    && git clone git@github.com:avarteqgmbh/git_flow_hooks.git /home/$USER/git_flow_hooks \
    && git config --global gitflow.path.hooks /home/$USER/git_flow_hooks/hooks \
    && git config --global gitflow.prefix.versiontag v \
    && chmod a+rwx /home/$USER/.gitconfig \
    && chmod a+rwx /home/$USER/.gitignore_global \
    && apt-get autoremove -y

# ZSH config
RUN apt-get update \
    && apt-get -y install zsh \
    && git clone git://github.com/robbyrussell/oh-my-zsh.git /home/$USER/.oh-my-zsh \
    && cp /home/$USER/.oh-my-zsh/templates/zshrc.zsh-template /home/$USER/.zshrc \
    && chsh -s /bin/zsh $USER \
    && echo export TERM=vt100 >> /home/$USER/.zshrc \
    && echo unsetopt prompt_cr prompt_sp >> /home/$USER/.zshrc \
    && echo '"5C": forward-word' >> /home/$USER/.inputrc \
    && echo '"5D": backward-word' >> /home/$USER/.inputrc \
    && echo '[[ -f ~/.inputrc ]] && export INPUTRC=~/.inputrc' >> /home/$USER/.zshrc \
    && echo 'bindkey "5C" forward-word' >> /home/$USER/.zshrc \
    && echo 'bindkey "5D" backward-word' >> /home/$USER/.zshrc \
    && echo 'export PROMPT=$(whoami)" "$PROMPT' >> /home/$USER/.zshrc \
    && echo 'stty sane' >> /home/$USER/.zshrc \
    && apt-get autoremove -y

# general tools
RUN apt-get update \
    && apt-get install -y mysql-client postgresql-client mongodb-clients jq \
    && apt-get autoremove -y

WORKDIR /home/$USER
USER $USER

CMD /bin/zsh
