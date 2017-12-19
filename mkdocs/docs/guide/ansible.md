Create an `ansible` user that will be used for the automation of the infrastructure.

```bash
make ansible
```

This will:

- Ensure an ansible user is exist on all nodes
- Configure this user with **sudo** privileges
- Register your SSH public key for the ansible user on all nodes (the keys created during the 
    [SSH](control-node/#ssh) steps)

!!! note
    In a real production environment you should probably remove the default cloud instance account.

!!! note
    This playbook to perform this uses the `bootstrap` inventory group.  This group is configured to use ssh via username/password (in the `group_vars/bootstrap.yml` configuration file) to configure the ssh passwordless log in.
