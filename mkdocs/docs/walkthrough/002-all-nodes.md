# All nodes

Configuration for all nodes

## Step 0

make 001-clock

TODO:
- combine the cloack and utilities

## Step 0

make 001-utilities

**TODO:**
- Internal NTP master

## Step 1

Log into the control machine and change to the directory with the
Makefile and ansible configuration

```
vagrant ssh control
cd /vagrant
```

## Step 2

Provision the Network Time Daemon

```
make 002-clock
```

## Step 3

Create an automation accout on all nodes.  This accounts is create specifically for automation purposes.

This will perform the following:

- Create the account `ansible`
- Create an `/etc/sudoers.d` entry for the account
- Add the control node user's ssh public key to the `ansible` user's ssh configure to enable passwordless log in.


```
make 002-ansible-account
```

**NOTE:**  In a real production environment you should probably remove the default cloud instance account.

**NOTE:** This playbook to perform this uses the `bootstrap` inventory group.  This group is configured to use ssh via username/password (in the `group_vars/bootstrap.yml` configuration file) to configure the ssh passwordless log in.

## Step 4

Install utility packages.

```
make 002-utilities
```
