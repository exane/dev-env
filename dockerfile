# serve ~ under 192.168.99.1:8080
# $ ruby -run -ehttpd ~ -p8080 -b192.168.99.1
#
# NEVER PUBLISH DOCKER IMAGE
# ssh private keys are saved
FROM ubuntu:xenial

ENV SERVE_HTTP_ADDRESS 192.168.99.1
ENV SERVE_HTTP_PORT 8080
ENV USER dev
ENV HOME /home/$USER

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y vim sudo software-properties-common python-software-properties apt-utils \
    && apt-get install -y wget curl \
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
    && apt-get autoremove -y \
    && mkdir $HOME/.ssh \
    && curl http://$SERVE_HTTP_ADDRESS:$SERVE_HTTP_PORT/.ssh/id_rsa -o $HOME/.ssh/id_rsa \
    && curl http://$SERVE_HTTP_ADDRESS:$SERVE_HTTP_PORT/.ssh/id_rsa_avarteq -o $HOME/.ssh/id_rsa_avarteq
COPY ssh_config /etc/ssh/ssh_config

# GIT config
RUN apt-get update \
    && curl http://$SERVE_HTTP_ADDRESS:$SERVE_HTTP_PORT/.gitconfig -o $HOME/.gitconfig \
    && curl http://$SERVE_HTTP_ADDRESS:$SERVE_HTTP_PORT/.gitignore_global -o $HOME/.gitignore_global \
    && apt-get -y install git git-flow \
    && chown $USER: $HOME/.ssh/id_rsa \
    && chmod u+r $HOME/.ssh/id_rsa \
    && eval $(ssh-agent -s) \
    && ssh-add $HOME/.ssh/id_rsa \
    && git clone git@github.com:avarteqgmbh/git_flow_hooks.git $HOME/git_flow_hooks \
    && git config --global gitflow.path.hooks $HOME/git_flow_hooks/hooks \
    && git config --global gitflow.prefix.versiontag v \
    && chmod a+rwx $HOME/.gitconfig \
    && chmod a+rwx $HOME/.gitignore_global \
    && apt-get autoremove -y

# ZSH config
COPY zshrc $HOME/.zshrc
COPY inputrc $HOME/.inputrc
RUN apt-get update \
    && chown $USER: $HOME/.zshrc $HOME/.inputrc \
    && apt-get -y install zsh \
    && git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh \
    && chsh -s /bin/zsh $USER \
    && apt-get autoremove -y

# general tools
RUN apt-get update \
    && apt-get install -y mysql-client postgresql-client mongodb-clients jq \
    && apt-get autoremove -y

COPY node.sh /tmp
RUN su -c /tmp/node.sh - $USER \
    && rm /tmp/node.sh

# TODO: put this line to the user config (top of the file)
RUN echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "Europe/Berlin" > /etc/timezone

COPY php.sh /tmp
RUN su -c /tmp/php.sh - $USER \
    && rm /tmp/php.sh

COPY ruby.sh /tmp
RUN su -c /tmp/ruby.sh - $USER \
    && rm /tmp/ruby.sh

WORKDIR /work
USER $USER

ENTRYPOINT /bin/zsh
