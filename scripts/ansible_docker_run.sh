#!/bin/bash

if [[ -z "$TEST" ]]; then
  INVENTORIES_PATH=inventories
else
  INVENTORIES_PATH=test_inventories
fi

if [[ -z "$INVENTORY" ]]; then
  echo "ERROR: INVENTORY is undefined!"
  exit 1
fi

if [[ -z "$PLAYBOOK" ]]; then
  echo "ERROR: PLAYBOOK is undefined!"
  exit 1
fi

set -x

ansible-playbook -i ${INVENTORIES_PATH}/${INVENTORY} playbooks/${INVENTORY}/${PLAYBOOK}.yml "${@:1}"
