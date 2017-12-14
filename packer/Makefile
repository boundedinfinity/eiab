makefile_dir		:= $(abspath $(shell pwd))

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

build:
	(cd boxcutter-centos && packer build -only=virtualbox-iso -var-file=../eiab-var.json centos.json)

add:
	vagrant box add --name bi/eiab boxcutter-centos/box/virtualbox/centos-7.4.box
