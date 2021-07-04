#!/bin/sh

# exit when any command fails
set -e

# run checks
for i in $(find ./terraform2/ -type f); do echo $i;cat $i; done
cd $WORKDIR
ansible-lint playbook.yaml
#ansible-playbook playbook.yaml -i inventory.yaml --diff --check
