#!/bin/bash

if [[ -z "$TEST" ]]; then
  INVENTORIES_PATH=inventories
else
  INVENTORIES_PATH=test_inventories
fi

if [[ -z "$SCENARIO" ]] ; then
  echo "ERROR: SCENARIO is undefined!"
  exit 1
fi

if [[ -z "$STRATEGY" ]] ; then
  echo "ERROR: STRATEGY is undefined!"
  exit 1
fi

set -x

ansible-playbook -i ${INVENTORIES_PATH}/${SCENARIO} playbooks/${SCENARIO}/${STRATEGY}.yml "${@:1}"
