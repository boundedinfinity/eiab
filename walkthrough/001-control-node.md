# Control Node

Configuring the control node.

## Step 1

Log into the control machine and change to the directory with the
Makefile and ansible configuration

```
vagrant ssh control
cd /vagrant
```

## Step 2

Install utility packages.

```
make 001-utilities
```

## Step 3

Generate the public key for the control node user, and import the
public ssh host	keys for all nodes in inventory.

```
make 001-configure-ssh
```
