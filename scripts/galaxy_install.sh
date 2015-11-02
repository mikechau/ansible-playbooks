#!/bin/bash

set -x

ansible-galaxy install -r requirements.yml --ignore-errors
