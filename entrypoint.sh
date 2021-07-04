#!/bin/sh

# exit when any command fails
set -e

# run checks
find ./
cd $WORKDIR
ansible-lint playbook.yaml
#ansible-playbook playbook.yaml -i inventory.yaml --diff --check
