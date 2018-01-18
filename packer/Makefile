makefile_dir		:= $(abspath $(shell pwd))

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

bootstrap:
	git clone https://github.com/boxcutter/fedora.git boxcutter-fedora

build:
	(cd boxcutter-fedora && packer build -only=virtualbox-iso -var-file=fedora27-server.json fedora.json)
	
add:
	vagrant box add --name bi/eiab-fedora boxcutter-fedora/box/virtualbox/fedora27-server-0.1.0.box
