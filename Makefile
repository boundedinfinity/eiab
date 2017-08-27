makefile_dir		:= $(abspath $(shell pwd))

ansible_account		:= ansible

ansible_exec		:= cd ansible && ansible --user=$(ansible_account) --ssh-common-args="-o StrictHostKeyChecking=no"
ansible_exec		:= cd ansible && ansible --user=$(ansible_account) --ssh-common-args="-o StrictHostKeyChecking=no"
playbook_exec		:= cd ansible && ansible-playbook --user=$(ansible_account) playbooks
playbook_v_exec		:= cd ansible && ansible-playbook -vvv --user=$(ansible_account) playbooks

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

001-ansible:
	mkdir -p ansible/galaxy_roles
	cd ansible && ansible-galaxy install --role-file=ansible-galaxy.yml
	
001-configure-ssh:
	$(playbook_exec)/001-configure-ssh.yml

002-ansible-account:
	$(playbook_exec)/002-ansible-account.yml

002-yum:
	$(playbook_exec)/002-yum.yml

002-pip:
	$(playbook_exec)/002-pip.yml
			
002-clock:
	$(playbook_exec)/002-clock.yml

002-utilities:
	$(playbook_exec)/002-utilities.yml

002-ulimit:
	$(playbook_exec)/002-ulimit.yml

002-admins:
	$(playbook_exec)/002-admins.yml

003-nexus-server:
	$(playbook_exec)/003-nexus-server.yml
		
003-nexus-repo:
	$(playbook_exec)/003-nexus-repo.yml
	# $(playbook_v_exec)/003-nexus-repo.yml

004-consul-server:
	$(playbook_exec)/004-consul-server.yml

004-consul-client:
	$(playbook_exec)/004-consul-client.yml

004-consul-dns:
	$(playbook_exec)/004-consul-dns.yml

005-nexus-consul:
	$(playbook_exec)/005-nexus-consul.yml

006-vault-server:
	$(playbook_exec)/006-vault-server.yml

006-vault-client:
	$(playbook_exec)/006-vault-client.yml

00X-prometheus-cache:
	$(playbook_exec)/00X-prometheus-cache.yml

999-everything:
	make 001-ansible
	make 001-configure-ssh
	make 002-ansible-account
	
	make 003-nexus-server
	make 003-nexus-repo
	make 002-yum
		
	make 002-clock
	make 002-utilities
		
	make 004-consul-server
	make 004-consul-client
	make 004-consul-dns
	
	make 005-nexus-consul
	
	make 006-vault-cache
	# make 006-vault-server
	# make 006-vault-client
	make 00X-prometheus-cache

999-debug:
	$(playbook_exec)/999-debug.yml

999-yum-clean:
	$(playbook_exec)/999-yum-clean.yml

wks-vagrant-bootstrap:
	vagrant plugin install vagrant-hostmanager

wks-vagrant-purge:
	vagrant halt && vagrant destroy -f

wks-vagrant-rebuild:
	vagrant halt && vagrant destroy -f && vagrant up

wks-vagrant-provision:
	vagrant provision

docs-open:
	open walkthrough2/_build/html/index.html

docs-generate:
	cd walkthrough2 && make html
	
# ansible-facts:
# 	$(ansible_exec) -m setup ops00
