# Configure the control node

Log into the control node.  Open a terminal, change to the `eiab` directory
and type:

```bash
vagrant ssh control
```

This will log you into the `control` virtual node.

Then type:

```bash
cd /vagrant
ls -l
```

You should see something similar to the following:

```bash
total 28
drwxr-xr-x. 1 vagrant vagrant  408 Aug 29 23:02 ansible/
drwxr-xr-x. 1 vagrant vagrant  442 Aug 31 23:30 doc/
-rw-r--r--. 1 vagrant vagrant 2554 Sep  1 04:42 Makefile
-rw-r--r--. 1 vagrant vagrant 2505 Jul 28 23:44 readme.md
-rw-r--r--. 1 vagrant vagrant 1334 Aug 22 05:56 Vagrantfile
```

You are now logged into the `control` node, and can see the files synced from your
workstation into the `control` node.

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
