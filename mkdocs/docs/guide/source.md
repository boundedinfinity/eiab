Download the source code for this project:

```bash
git clone https://github.com/boundedinfinity/eiab.git
```

This will create the following directory structure:

```
eiab
├── ansible/
├── mkdocs/
├── packer/
├── Brewfile
├── readme.md
├── Makefile 
└── Vagrantfile
```

For the rest of the guide the **eiab** directory will be denoted as something like `$EIAB_DIR` for
the purposes of scripts and examples.

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
terminal, change to the root `EIAB_DIR` directory and type:

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
