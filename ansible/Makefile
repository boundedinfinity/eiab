makefile_dir		:= $(abspath $(shell pwd))

ansible_account		:= ansible

ansible_exec		:= ansible --user=$(ansible_account)
playbook_exec		:= ansible-playbook --user=$(ansible_account) playbooks
playbook_v_exec		:= ansible-playbook -vvv --user=$(ansible_account) playbooks

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

all:
	make control-node-ntp
	make control-node-roles
	make control-node-gpg
	make control-node-ssh


control-node-gpg:
	$(playbook_exec)/control-node-gpg.yml

control-node-ntp:
	$(playbook_exec)/control-node-ntp.yml

control-node-roles:
	mkdir -p galaxy_roles
	ansible-galaxy install --role-file=ansible-galaxy.yml

control-node-usershelld:
	$(playbook_exec)/control-node-usershelld.yml

control-node-ssh:
	$(playbook_exec)/control-node-ssh.yml


001-ansible-account:
	$(playbook_exec)/001-ansible-account.yml


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
	make 001-usershelld
	make 001-gpg
	make 001-keychain
	
	make 001-ansible
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

999-doc:
	$(playbook_exec)/999-doc.yml

999-debug:
	$(playbook_exec)/999-debug.yml

999-yum-clean:
	$(playbook_exec)/999-yum-clean.yml

999-facts-local:
	$(playbook_exec)/999-facts-local.yml

999-purge:
	rm -rf ansible/galaxy_roles

wks-vagrant-purge:
	vagrant halt && vagrant destroy -f

wks-vagrant-rebuild:
	vagrant halt && vagrant destroy -f && vagrant up

wks-vagrant-provision:
	vagrant provision

docs-open:
	open $(makefile_dir)/doc/_build/index.html

docs-build:
	cd doc && make build

docs-build-watch:
	cd doc && make build-watch

docs-purge:
	cd doc && make purge
