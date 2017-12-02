# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 2.0.1"

node_count = 2
node_mem = 768
ops_mem = 1536

$script = <<SCRIPT
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y ansible fish
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "bi/eiab"
  config.hostmanager.enabled = false

  (0..node_count).each do |i|
      config.vm.define "ops0#{i}" do |m|
          m.vm.hostname = "ops0#{i}"
          m.vm.network "private_network", ip: "10.0.0.1#{i}"
          m.vm.provider "virtualbox" do |v|
              v.memory = ops_mem
          end
      end
  end

  (0..node_count).each do |i|
      config.vm.define "app0#{i}" do |m|
          m.vm.hostname = "app0#{i}"
          m.vm.network "private_network", ip: "10.0.0.2#{i}"
      end
  end

  (0..node_count).each do |i|
      config.vm.define "ds0#{i}" do |m|
          m.vm.hostname = "ds0#{i}"
          m.vm.network "private_network", ip: "10.0.0.3#{i}"
      end
  end
  
  config.vm.define "control", primary: true do |m|
      m.vm.provision "shell", inline: $script
      m.vm.provision :hostmanager
      m.vm.hostname = "control"
      m.vm.network "private_network", ip: "10.0.0.2"
      m.hostmanager.enabled = true
      m.hostmanager.include_offline = true
  end
end
