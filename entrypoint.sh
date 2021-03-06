#!/bin/sh

# exit when any command fails
set -e

if [ "$APPLY" = "true" ];then
  # create inventory file
  (
  cat << EOF
[webserver]
EOF
  ) > $WORKDIR/inventory.yaml

  # add target vm ip
  cat ./terraform2/public_ip >> $WORKDIR/inventory.yaml
  
  cat $WORKDIR/inventory.yaml
fi

# go to project
cd $WORKDIR

# run checks
#for i in $(find ./terraform2/ -type f | grep -v ".terraform/providers"); do echo $i;cat $i; done
if [ "$APPLY" = "true" ];then
  #ansible-playbook playbook.yaml -i inventory.yaml --diff --check
  echo "$SSH_PRIVATE_KEY" | base64 -d > key
  ansible-playbook playbook.yaml -i inventory.yaml --key-file "key"
else
  ansible-lint playbook.yaml
fi
