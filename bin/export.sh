set -eu

VM="test"

export_vm() {
  rm tmp/$VM.ova
  VBoxManage export $VM -o tmp/$VM.ova
}

read -p "Export VM $VM setup to tmp/$VM.ova and overwrite if exists (y/n)?" choice
case "$choice" in 
  y|Y ) export_vm;;
  n|N ) exit 0;;
  * ) echo "invalid";;
esac
