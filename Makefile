makefile_dir		:= $(abspath $(shell pwd))

ansible_account		:= ansible

ansible_exec		:= cd ansible && ansible --user=$(ansible_account)
playbook_exec		:= cd ansible && ansible-playbook --user=$(ansible_account) playbooks
playbook_v_exec		:= cd ansible && ansible-playbook -vvv --user=$(ansible_account) playbooks

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

001-ansible:
	mkdir -p ansible/galaxy_roles
	cd ansible && ansible-galaxy install --role-file=ansible-galaxy.yml
	
001-configure-ssh:
	$(playbook_exec)/001-configure-ssh.yml

001-ansible-account:
	$(playbook_exec)/001-ansible-account.yml

001-usershelld:
	$(playbook_exec)/001-usershelld.yml

001-gpg:
	$(playbook_exec)/001-gpg.yml

002-nexus-server:
	$(playbook_exec)/002-nexus-server.yml
		
002-nexus-repo:
	$(playbook_exec)/002-nexus-repo.yml
	# $(playbook_v_exec)/002-nexus-repo.yml

002-yum:
	$(playbook_exec)/002-yum.yml

002-pip:
	$(playbook_exec)/002-pip.yml
			
003-clock:
	$(playbook_exec)/003-clock.yml

003-utilities:
	$(playbook_exec)/003-utilities.yml

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
	make 001-usershelld
	make 001-configure-ssh
	make 001-ansible-account
	
	make 002-nexus-server
	make 002-nexus-repo
	make 002-yum
	make 002-pip
	
	make 003-clock
	make 003-utilities
		
	make 004-consul-server
	make 004-consul-client
	make 004-consul-dns
	
	make 005-nexus-consul
	
	make 006-vault-server
	make 006-vault-client
	
	make 00X-prometheus-cache

999-debug:
	$(playbook_exec)/999-debug.yml

999-yum-clean:
	$(playbook_exec)/999-yum-clean.yml

999-facts-local:
	$(playbook_exec)/999-facts-local.yml

999-purge:
	rm -rf ansible/galaxy_roles

wks-vagrant-bootstrap:
	vagrant plugin install vagrant-hostmanager

wks-vagrant-purge:
	vagrant halt && vagrant destroy -f

wks-vagrant-rebuild:
	vagrant halt && vagrant destroy -f && vagrant up

wks-vagrant-provision:
	vagrant provision

docs-open:
	open docs/_build/html/index.html

docs-build:
	cd doc && make build

docs-build-watch:
	cd doc && make build-watch
