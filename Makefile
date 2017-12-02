makefile_dir		:= $(abspath $(shell pwd))

ansible_account		:= ansible

ansible_exec		:= cd ansible && ansible --user=$(ansible_account)
playbook_exec		:= cd ansible && ansible-playbook --user=$(ansible_account) playbooks
playbook_v_exec		:= cd ansible && ansible-playbook -vvv --user=$(ansible_account) playbooks

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

vagrant-bootstrap:
	vagrant plugin install vagrant-hostmanager


