makefile_dir		:= $(abspath $(shell pwd))

ansible_account		:= ansible

ansible_exec		:= ansible --user=$(ansible_account)
playbook_exec		:= ansible-playbook --user=$(ansible_account) playbooks
playbook_v_exec		:= ansible-playbook -vvv --user=$(ansible_account) playbooks

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

clean:
	rm -rf galaxy_roles

everything:
	make control-node-ntp
	make control-node-roles
	make control-node-usershelld
	make control-node-ssh
	# add keys to agent
	make control-node-gpg
	# create key
	make ansible
	make all-nodes-ntp
	make all-nodes-utilities
	make consul-server
	make consul-client
	make vault-server
	make vault-client

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

ansible:
	$(playbook_exec)/ansible.yml

all-nodes-ntp:
	$(playbook_exec)/all-nodes-ntp.yml

all-nodes-utilities:
	$(playbook_exec)/all-nodes-utilities.yml

consul-server:
	$(playbook_exec)/consul-server.yml

consul-client:
	$(playbook_exec)/consul-client.yml

vault-server:
	$(playbook_exec)/vault-server.yml

vault-client:
	$(playbook_exec)/vault-client.yml

002-nexus-server:
	$(playbook_exec)/002-nexus-server.yml
		
002-nexus-repo:
	$(playbook_exec)/002-nexus-repo.yml
	# $(playbook_v_exec)/002-nexus-repo.yml

002-yum:
	$(playbook_exec)/002-yum.yml

002-pip:
	$(playbook_exec)/002-pip.yml

005-nexus-consul:
	$(playbook_exec)/005-nexus-consul.yml

00X-prometheus-cache:
	$(playbook_exec)/00X-prometheus-cache.yml

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
