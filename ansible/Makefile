makefile_dir		:= $(abspath $(shell pwd))

default_account		:= centos
ansible_account		:= ansible

playbook			:= ansible-playbook --user=$(ansible_account)

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

001-ansible-account:
	ansible-playbook --user=$(default_account) 001-ansible-account.yml

002-default-account:
	$(playbook) 002-default-account.yml

003-consul:
	$(playbook) 002-consul.yml
