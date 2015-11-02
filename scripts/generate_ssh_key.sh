#!/bin/bash

if [[ -z $1 ]]; then
  echo "ERROR: First argument is required!"
  echo "Must be a file name to generate ssh keys for."
  exit 1
fi

set -x

ssh-keygen -f {$1} -t rsa -N ''
