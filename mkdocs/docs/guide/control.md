The following series of command must be ran from the `$EIAB_DIR`:

```bash
cd $EIAB_DIR
```

Now it's time to start up the **control** node:

```bash
vagrant up control
```

Log into the **control** node.

```bash
vagrant ssh control
```

Once inside the VM, the following series of command must be ran from the `/vagrant`:

Then type:

```bash
cd /vagrant
```

Once inside the **/vagrant** directory perform a directory listing. You should see something similar 
to the following:

```bash
ls -l 
drwxr-xr-x.  1 vagrant vagrant  544 Dec  2 05:33 .
dr-xr-xr-x. 18 root    root     239 Dec  2 05:27 ..
drwxr-xr-x.  1 vagrant vagrant  408 Aug 29 23:02 ansible
-rw-r--r--.  1 vagrant vagrant  175 Dec  2 05:29 Brewfile
-rw-r--r--.  1 vagrant vagrant  133 Aug 19 07:25 .editorconfig
drwxr-xr-x.  1 vagrant vagrant  510 Dec  2 01:07 .git
-rw-r--r--.  1 vagrant vagrant   29 Aug 25 19:11 .gitignore
-rw-r--r--.  1 vagrant vagrant 2621 Sep  2 06:29 Makefile
drwxr-xr-x.  1 vagrant vagrant  238 Nov 25 00:20 mkdocs
drwxr-xr-x.  1 vagrant vagrant  204 Dec  2 01:12 packer
-rw-r--r--.  1 vagrant vagrant 2505 Jul 28 23:44 readme.md
-rw-r--r--.  1 vagrant vagrant  346 Aug 19 05:53 research.md
-rw-r--r--.  1 vagrant vagrant 2440 Aug 19 05:53 services.md
-rw-r--r--.  1 vagrant vagrant  352 Aug 20 10:58 temp.md
drwxr-xr-x.  1 vagrant vagrant  102 Aug 19 06:17 .vagrant
-rw-r--r--.  1 vagrant vagrant 1323 Dec  2 05:26 Vagrantfile
```

The content may not exactly match the example above, but the important thing is that
you should see the project files.


The following series of command must be ran from the `/vagrant/ansible` directory:

Then type:

```bash
cd /vagrant/ansible
```

# Credentials

To help manage credentials:

```bash
cd /vagrant
make 001-gpg
```

This will:

- Install the [Gnu Privacy Guard](https://gnupg.org) (GPG) encryption software
- Install the Random number generator utilities

After installation you can open a terminal and type:

```bash
gpg --version
```

You should see something similar to the following.

```bash
gpg (GnuPG) 2.0.22
libgcrypt 1.5.3
...
```

Help generate some random entropy to key generation.  This step is mainly 
required because of running inside the VM.  This shouldn't be necessary
when running on a physical computer.

```bash
sudo rngd -r /dev/urandom
```

Create your master public and private keys.

```bash
~/gpg-master.expect
```

This will create a key with the following parameters:

- Key type: `default`
- Key lenght: `4096`
- Real name: `Vagrant Baggins`
- Email: `vagrant@eiab.net`
- Expire Date: `0`
- Capabilities: Certify

When prompted for your pass phrase, enter: `aaaa1234`.  In a real environmnet
you'll want to create a very hard to guess password.

Verify your public and private key:

```bash
gpg --export vagrant@eiab.net | base64
```

Create a subkey for use as the ssh authentication key pair.

```bash
gpg --expert --edit-key vagrant@eiab.net
addkey
8
S
E
A
Q
4096
0
y
y
save
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
