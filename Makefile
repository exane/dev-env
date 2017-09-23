build: rebuild package

destroy:
	vagrant destroy -f

up:
	vagrant up

rebuild: destroy up

base:
	vagrant up --no-provision

rebuild-base: destroy base

package:
	rm -rf package.box
	vagrant package
	vagrant box add exane/ubuntu package.box --force
