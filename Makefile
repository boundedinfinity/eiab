makefile_dir		:= $(abspath $(shell pwd))

ansible_account		:= ansible

ansible_exec		:= cd ansible && ansible --user=$(ansible_account)
playbook_exec		:= cd ansible && ansible-playbook --user=$(ansible_account) playbooks

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

001-clock:
	$(playbook_exec)/001-clock.yml

001-utilities:
	$(playbook_exec)/001-utilities.yml

001-configure-ssh:
	$(playbook_exec)/001-configure-ssh.yml

002-ansible-account:
	$(playbook_exec)/002-ansible-account.yml

002-clock:
	$(playbook_exec)/002-clock.yml

002-utilities:
	$(playbook_exec)/002-utilities.yml

002-admins:
	$(playbook_exec)/002-admins.yml

003-consul-server:
	$(playbook_exec)/003-consul-server.yml

003-consul-client:
	$(playbook_exec)/003-consul-client.yml

003-dns:
	$(playbook_exec)/003-dns.yml

004-vault-server:
	$(playbook_exec)/004-vault-server.yml

004-vault-client:
	$(playbook_exec)/004-vault-client.yml

999-everything:
	make 001-clock
	make 001-utilities
	make 001-configure-ssh
	make 002-ansible-account
	make 002-clock
	make 002-utilities
	# make 002-admins
	make 003-consul-server
	make 003-consul-client
	make 003-dns
	make 004-vault-server
	make 004-vault-client

wks-vagrant-purge:
	vagrant halt && vagrant destroy -f

wks-vagrant-rebuild:
	vagrant halt && vagrant destroy -f && vagrant up

wks-vagrant-provision:
	vagrant provision

ansible-facts:
	$(ansible_exec) --ask-pass -m setup 10.0.0.10
