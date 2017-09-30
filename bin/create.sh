#!/bin/bash
set -eu

VM="test"

rm "$HOME/VirtualBox VMs/$VM/$VM.vbox" || true
VBoxManage unregistervm $VM --delete || true

wget http://releases.ubuntu.com/16.04.3/ubuntu-16.04.3-server-amd64.iso -O tmp/ubuntu-16.04.3.iso -Nc --progress=bar

VBoxManage createhd --filename tmp/$VM.vdi --size 5120
VBoxManage createvm --name $VM --ostype "Ubuntu_64" --register

VBoxManage modifyvm $VM --usb on --usbehci on

VBoxManage storagectl $VM --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach $VM --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium tmp/$VM.vdi

VBoxManage storagectl $VM --name "IDE Controller" --add ide
VBoxManage storageattach $VM --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium tmp/ubuntu-16.04.3.iso

VBoxManage modifyvm $VM --ioapic on
VBoxManage modifyvm $VM --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage modifyvm $VM --memory 1024 --vram 128
# VBoxManage modifyvm $VM --nic1 bridged --bridgeadapter1 e1000g0

# VBoxHeadless -s $VM
VBoxManage startvm $VM

# Do the guided installer manually and then run ./bin/export.sh and then ./bin/setup
