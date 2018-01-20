makefile_dir		:= $(abspath $(shell pwd))

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

bootstrap:
	git clone https://github.com/boxcutter/fedora.git boxcutter-fedora
	git clone https://github.com/boxcutter/centos.git boxcutter-centos

build:
	@make build-centos
	@make build-fedora
	
build-centos:
	(cd boxcutter-centos && packer build -only=virtualbox-iso -var-file=../centos-74-var.json centos.json)

build-fedora:
	(cd boxcutter-fedora && packer build -only=virtualbox-iso -var-file=../fedora-27-var.json fedora.json)	
	
add:
	@make add-centos
	@make add-fedora

add-centos:
	vagrant box add --name bi/eiab-centos boxcutter-centos/box/virtualbox/centos-74.box

add-fedora:
	vagrant box add --name bi/eiab-fedora boxcutter-fedora/box/virtualbox/fedora-24.box
