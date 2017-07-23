#!/bin/sh

vagrant destroy -f && vagrant up
rm -rf package.box
vagrant package
vagrant box add exane/ubuntu package.box --force
