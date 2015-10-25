# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.ssh.forward_agent = true

  config.vm.provider 'virtualbox' do |vb|
    vb.customize ['modifyvm', :id, '--vram', '10']
    vb.customize ['modifyvm', :id, '--cpuexecutioncap', '80']
  end

  config.vm.define 'default', primary: true do |v|
    v.vm.network 'private_network', ip: '11.11.11.01'

    v.vm.provider 'virtualbox' do |vb|
      vb.name = 'ap-default'
      vb.customize ['modifyvm', :id, '--memory', '256']
      vb.customize ['modifyvm', :id, '--cpus', '1']
    end
  end

  config.vm.define 'rails_1', autostart: false do |v|
    v.vm.network 'private_network', ip: '11.11.11.02'

    v.vm.network 'forwarded_port', guest: 80, host: 8080, auto_correct: true
    v.vm.network 'forwarded_port', guest: 3000, host: 3000, auto_correct: true
    v.vm.network 'forwarded_port', guest: 3001, host: 3001, auto_correct: true
    v.vm.network 'forwarded_port', guest: 5432, host: 5432, auto_correct: true

    v.vm.provider 'virtualbox' do |vb|
      vb.name = 'ap-rails_1'
      vb.customize ['modifyvm', :id, '--memory', '1024']
      vb.customize ['modifyvm', :id, '--cpus', '2']
    end

    v.vm.provision :ansible do |ansible|
      ansible.limit = 'all'
      ansible.inventory_path = 'inventories/rails_1'
      ansible.playbook = 'playbooks/rails_1/provision.yml'
      ansible.verbose = 'vv'
    end
  end

  if Vagrant.has_plugin?('vagrant-vbguest')
    config.vbguest.auto_update = true
  end
end
