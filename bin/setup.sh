set -eu

VM="test"

import_vm() {
  VBoxManage unregistervm $VM-dev --delete || true
  VBoxManage import tmp/$VM.ova --vsys 0 --vmname $VM-dev
}

read -p "Overwrite $VM-dev VM Box (y/n)?" choice
case "$choice" in 
  y|Y ) import_vm;;
  n|N ) exit 0;;
  * ) echo "invalid";;
esac
