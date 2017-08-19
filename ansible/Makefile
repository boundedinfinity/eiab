makefile_dir		:= $(abspath $(shell pwd))

default_account		:= centos
ansible_account		:= ansible

playbook_default	:= ansible-playbook --user=$(default_account)
playbook_ansible	:= ansible-playbook --user=$(ansible_account)

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

002-ansible-account:
	$(playbook_default) playbooks/002-ansible-account.yml

002-ansible-account-normal:
	$(playbook_ansible) playbooks/002-ansible-account.yml

003-default-account:
	$(playbook_ansible) playbooks/003-default-account.yml

005-admins:
	$(playbook_ansible) playbooks/005-admins.yml

006-utilities:
	$(playbook_ansible) playbooks/006-utilities.yml

007-consul-server:
	$(playbook_ansible) playbooks/007-consul-server.yml

008-consul-client:
	$(playbook_ansible) playbooks/008-consul-client.yml

010-vault:
	$(playbook_ansible) playbooks/010-vault.yml
