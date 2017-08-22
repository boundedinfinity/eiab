makefile_dir		:= $(abspath $(shell pwd))

ansible_account		:= ansible

ansible_exec		:= cd ansible && ansible --user=$(ansible_account) --ssh-common-args="-o StrictHostKeyChecking=no"
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

003-fileserver:
	$(playbook_exec)/003-fileserver.yml

004-consul-cache:
	$(playbook_exec)/004-consul-cache.yml
		
004-consul-server:
	$(playbook_exec)/004-consul-server.yml

004-consul-client:
	$(playbook_exec)/004-consul-client.yml

004-dns:
	$(playbook_exec)/004-dns.yml

005-consul-fileserver:
	$(playbook_exec)/005-consul-fileserver.yml

006-vault-cache:
	$(playbook_exec)/006-vault-cache.yml
		
006-vault-server:
	$(playbook_exec)/006-vault-server.yml

006-vault-client:
	$(playbook_exec)/006-vault-client.yml

00X-nexus-cache:
	$(playbook_exec)/00X-nexus-cache.yml

00X-nexus-server:
	$(playbook_exec)/00X-nexus-server.yml

00X-prometheus-cache:
	$(playbook_exec)/00X-prometheus-cache.yml

999-everything:
	make 001-clock
	make 001-utilities
	make 001-configure-ssh
	make 002-ansible-account
	make 002-clock
	make 002-utilities
	# make 002-admins
	make 003-fileserver
	make 004-consul-cache
	make 004-consul-server
	make 004-consul-client
	make 004-dns
	make 005-consul-fileserver
	make 006-vault-cache
	# make 006-vault-server
	# make 006-vault-client

999-debug:
	$(playbook_exec)/999-debug.yml

wks-vagrant-bootstrap:
	vagrant plugin install vagrant-hostmanager

wks-vagrant-purge:
	vagrant halt && vagrant destroy -f

wks-vagrant-rebuild:
	vagrant halt && vagrant destroy -f && vagrant up

wks-vagrant-provision:
	vagrant provision

# ansible-facts:
# 	$(ansible_exec) -m setup ops00
