# Bootstrapping the environment

This will be a one time setup.  This procedure will only need to be perform
once per computer.

## Virtualbox

First install the [VirtualBox](https://www.virtualbox.org) virtualization
system.  This will allow you to provision virtualized guest operating system.

After installation you can open a terminal and type:

```bash
vboxmanage --version
```

You should see something similar to the following:

```bash
5.1.26r117224
```

## Vagrant

Next install the [Vagrant](https://www.vagrantup.com) virtualization managment
and workflow tools.  This is manage the provisioning of the virtualized guest
systems used in this tutorial.

After installation you can open a terminal and type:

```bash
vagrant --version
```

You should see something similar to the following:

```bash
Vagrant 1.9.7
```

## Make

This tutorial is driven primary by the [Make](https://www.gnu.org/software/make)
build system.  It provides a simple system to control simple auotmation flows
which allows you to *make* things.  Most Linux system and OSX should have this
program installed.

After installation you can open a terminal and type:

```bash
make --version
```

You should see something similar to the following:

```bash
GNU Make 3.81
...
```

## SSH

A secure shell system.  Most Linux systems and OSX should have the 
[OpenSSH](https://www.openssh.com) system installed.

After installation you can open a terminal and type:

```bash
ssh -v localhost
```

You should see something similar to the following:

```bash
OpenSSH_7.4p1, LibreSSL 2.5.0
...
```

## Bootstrap

Now it's time to perform the first step in the tutorial.  Open a terminal,
change to the root `eiab` directory and type:

```bash
make 001-bootstrap
```

This will install the Vagrant `vagrant-hostmanager` plugin which helps to manage
an easy hostname mapping for the Vagrant created guest host used in this 
tutorial.

## Create the environment

The preperation is now complete.  To build the tutorial environment, open a 
terminal, change to the root `eiab` directory and type:

```bash
vagrant up
```

This will download, cache, provision and start an entprise cluster using the 
Centos 7.3 operating system.  The cluster will consist of the following:

- control tier - 1 node used to provision and control the other tiers.
- operations tier - 3 nodes that contain the operations service and tools 
  required to manage this environment.
- application tier - 3 nodes that contain the custom built applications.
- datastore tier -  3 nodes that contain persistant storage services 
  (such as database) required by the operations and applications tier.

**NOTE:** This step may take some time (possibly > 20 minutes)
