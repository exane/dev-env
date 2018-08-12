#!/bin/bash
set -eu

make_persistant() {
  name=$1

  config "if [ ! -d /store/$name ]; then"
  config "  mkdir /store/$name/"
  config "  cp -r ~/$name/* /store/$name"
  config "fi"
  config "rm -rf ~/$name"
  config "ln -s /store/$name -T ~/$name"
}

config() {
  echo $1 >> /home/dev/.zshrc
}

add_path() {
  config "export PATH=$PATH:$1"
}
