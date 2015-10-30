#!/bin/bash

if [[ -z $1 ]]; then
  echo "ERROR: Inventory is not defined!"
  exit 1
fi

if [[ -z $2 ]]; then
  echo "ERROR: Playbook is not defined!"
  exit 1
fi

set -x
ansible-playbook -i inventories/${1} playbooks/${1}/${2}.yml --syntax-check
