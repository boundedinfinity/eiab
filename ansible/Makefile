makefile_dir		:= $(abspath $(shell pwd))

default_account		:= centos
ansible_account		:= ansible

playbook_default	:= ansible-playbook --user=$(default_account)
playbook_ansible	:= ansible-playbook --user=$(ansible_account)

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

001-ansible-account-bootstrap:
	$(playbook_default) playbooks/001-ansible-account.yml

001-ansible-account:
	$(playbook_ansible) playbooks/001-ansible-account.yml

002-default-account:
	$(playbook_ansible) playbooks/002-default-account.yml

003-admins:
	$(playbook_ansible) playbooks/003-admins.yml

004-utilities:
	$(playbook_ansible) playbooks/003-utilities.yml

005-consul-server:
	$(playbook_ansible) playbooks/004-consul-server.yml

006-consul-client:
	$(playbook_ansible) playbooks/005-consul-client.yml

007-vault:
	$(playbook_ansible) playbooks/006-vault.yml
