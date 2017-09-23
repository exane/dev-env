build: rebuild package

destroy:
	vagrant destroy -f

up:
	vagrant up

rebuild: destroy up

package:
	rm -rf package.box
	vagrant package
	vagrant box add exane/ubuntu package.box --force
