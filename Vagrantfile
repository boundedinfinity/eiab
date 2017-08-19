# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y ansible
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "boxcutter/centos73"

  config.vm.define "control", primary: true do |m|
      m.vm.provision "shell", inline: $script
      m.vm.hostname = "control"
      m.vm.network "private_network", ip: "10.0.0.2"
  end

  config.vm.define "ops01" do |m|
      m.vm.hostname = "ops01"
      m.vm.network "private_network", ip: "10.0.0.10"
  end

  config.vm.define "ops02" do |m|
      m.vm.hostname = "ops02"
      m.vm.network "private_network", ip: "10.0.0.11"
  end

  config.vm.define "ops03" do |m|
      m.vm.hostname = "ops03"
      m.vm.network "private_network", ip: "10.0.0.12"
  end

  config.vm.define "app01" do |m|
      m.vm.hostname = "app01"
      m.vm.network "private_network", ip: "10.0.0.20"
  end

  config.vm.define "app02" do |m|
      m.vm.hostname = "app02"
      m.vm.network "private_network", ip: "10.0.0.21"
  end

  config.vm.define "app03" do |m|
      m.vm.hostname = "app03"
      m.vm.network "private_network", ip: "10.0.0.22"
  end

  config.vm.define "ds01" do |m|
      m.vm.hostname = "ds01"
      m.vm.network "private_network", ip: "10.0.0.30"
  end

  config.vm.define "ds02" do |m|
      m.vm.hostname = "ds02"
      m.vm.network "private_network", ip: "10.0.0.31"
  end

  config.vm.define "ds03" do |m|
      m.vm.hostname = "ds03"
      m.vm.network "private_network", ip: "10.0.0.32"
  end
end
