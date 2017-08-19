makefile_dir		:= $(abspath $(shell pwd))

default_account		:= centos
ansible_account		:= ansible

playbook_default	:= cd ansible && ansible-playbook --user=$(default_account) playbooks
playbook_ansible	:= cd ansible && ansible-playbook --user=$(ansible_account) playbooks

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

000-ssh-add-hosts:
	$(playbook_default)/ssh-add-hosts.yml

002-ansible-account:
	$(playbook_default)/002-ansible-account.yml

002-ansible-account-normal:
	$(playbook_ansible)/002-ansible-account.yml

003-default-account:
	$(playbook_ansible)/003-default-account.yml

005-admins:
	$(playbook_ansible)/005-admins.yml

006-utilities:
	$(playbook_ansible)/006-utilities.yml

007-consul-server:
	$(playbook_ansible)/007-consul-server.yml

008-consul-client:
	$(playbook_ansible)/008-consul-client.yml

010-vault:
	$(playbook_ansible)/010-vault.yml

wks-vagrant-purge:
	vagrant halt && vagrant destroy -f

wks-vagrant-rebuild:
	vagrant halt && vagrant destroy -f && vagrant up

wks-vagrant-provision:
	vagrant provision
