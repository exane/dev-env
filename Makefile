build: destroy up package

destroy:
	vagrant destroy -f

up:
	vagrant up

package:
	rm -rf package.box
	vagrant package
	vagrant box add exane/ubuntu package.box --force
