makefile_dir		:= $(abspath $(shell pwd))

ansible_account		:= ansible

ansible_exec		:= cd ansible && ansible --user=$(ansible_account)
playbook_exec		:= cd ansible && ansible-playbook --user=$(ansible_account) playbooks
playbook_v_exec		:= cd ansible && ansible-playbook -vvv --user=$(ansible_account) playbooks

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

bootstrap:
	vagrant plugin install vagrant-hostmanager

clean:
	vagrant halt
	vagrant destroy -f
	cd ansible && make clean
	vagrant up

startover:
	make clean
	vagrant up


