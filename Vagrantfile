# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "boxcutter/centos73"

  config.vm.define "control", primary: true do |control|
      control.vm.network "private_network", ip: "10.0.0.2"
  end
  
  config.vm.define "ops01" do |ops01|
      ops01.vm.network "private_network", ip: "10.0.0.10"
  end
  
  config.vm.define "ops02" do |ops02|
      ops02.vm.network "private_network", ip: "10.0.0.11"
  end
  
  config.vm.define "ops03" do |ops03|
      ops03.vm.network "private_network", ip: "10.0.0.12"
  end
  
  config.vm.define "app01" do |app01|
      app01.vm.network "private_network", ip: "10.0.0.20"
  end
  
  config.vm.define "app02" do |app02|
      app02.vm.network "private_network", ip: "10.0.0.21"
  end
  
  config.vm.define "app03" do |app03|
      app03.vm.network "private_network", ip: "10.0.0.22"
  end
  
  config.vm.define "ds01" do |ds01|
      ds01.vm.network "private_network", ip: "10.0.0.30"
  end
  
  config.vm.define "ds02" do |ds02|
      ds02.vm.network "private_network", ip: "10.0.0.31"
  end
  
  config.vm.define "ds03" do |ds03|
      ds03.vm.network "private_network", ip: "10.0.0.32"
  end
end
