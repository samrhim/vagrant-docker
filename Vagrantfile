# -*- mode: ruby -*-
# vi:set ft=ruby sw=2 ts=2 sts=2:

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility).

Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/focal64"
  config.vm.box_check_update = false
  config.ssh.insert_key = false
# config.vm.synced_folder "../.", "/vagrant_data"

# Provision docker Node
    
    config.vm.define "docker" do |docker|
      docker.vm.hostname = "docker.clevory.local"
      docker.vm.provision "shell", path: "docker.sh"
      docker.vm.network "private_network", ip: "192.168.1.200"
      docker.vm.provider "virtualbox" do |vb|
        vb.memory = "4096"
        vb.name = "docker"
      end
    end
end