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

  # get target vm ip
  cat ./../terraform2/terraform.tfstate | jq '.resources[] | select(.type == "aws_instance") | .instances[].attributes.public_ip ' >> $WORKDIR/inventory.yaml
  cat $WORKDIR/inventory.yaml
fi

# go to project
cd $WORKDIR

# run checks
#for i in $(find ./terraform2/ -type f | grep -v ".terraform/providers"); do echo $i;cat $i; done
ansible-lint playbook.yaml
if [ "$APPLY" = "true" ];then
  #ansible-playbook playbook.yaml -i inventory.yaml --diff --check
  ansible-playbook playbook.yaml -i inventory.yaml
fi
