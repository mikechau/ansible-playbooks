# ansible-playbooks

[![Build Status](https://travis-ci.org/mikechau/ansible-playbooks.svg?branch=master)](https://travis-ci.org/mikechau/ansible-playbooks)

This is a collection of playbooks, primarily to test out certain playbook configurations. It also serves as a central location for roles that may be eventually extracted out and added to Ansible Galaxy.

## Requirements

- Vagrant
- Ansible
- Ruby

## Setup

```
# From project root
./scripts/update_insecure_keys_permissions.sh
./scripts/galaxy_install.sh

bundle install
```

## Playbooks

### Scenario: rails_1
#### Rails Blue/Green deploy with Passenger Standalone and Nginx

This playbook covers a scenario where you have a rails application that you want to deploy with Passenger Standalone and do blue/green deploys, for zero downtime.

It entails provisioning and deploying.

## Testing

#### Vagrant

Vagrant is used to set up a virtualized environment, each scenario is defined as a specific virtual machine in the Vagrantfile.

```
# Start vagrant for a scenario
vagrant up ${scenario_name}

vagrant up rails_1
```

#### Serverspec

Serverspec is used to write RSpec tests to verify the playbook has run as intended.

```
# Run tests for everything
rake

# Run test for specific scenario

TARGET_HOST=${scenario_name} rspec ./spec/${scenario_name}/${test_name}.rb

TARGET_HOST=rails_1 rspec ./spec/rails_1/provision_ubuntu_spec.rb
```

## LICENSE

MIT
