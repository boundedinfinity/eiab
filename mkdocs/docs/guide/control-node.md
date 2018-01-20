The following series of command must be ran from the `$EIAB_DIR`:

```bash
cd $EIAB_DIR
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

```bash
cd /vagrant/ansible
```

### Clock

Configure the clock via the [Network Time Protocol](http://www.ntp.org).  This will fix 
clock skew errors.

```bash
make control-node-ntp
```

### Ansible roles

Install any required third party roles from [Ansible Galaxy](https://galaxy.ansible.com).

```bash
make control-node-roles
```

!!! warning
    Forgot what this is for.

### SSH

Configure the [SSH](../tools/ssh) utilities.

```
make control-node-ssh
```

This will:

- Install a **ssh-agent** lifecycle management scripts using the [UserShellD](../tools/usershelld) framework.
- Generate the ssh keypair with the `There and back again!` as the passphrase
- Import the remote host fingerprints from all the nodes in the architecture

!!! note
    To properly enable the SSH agent functionality, log out of the control node
    and log back in.

After installation you can open a terminal and type:

```bash
ssh -V
```

You should see something similar to the following.

```bash
OpenSSH_7.6p1, LibreSSL 2.6.2
```

Then you'll need to add your generated key to the cache:

```bash
ssh-add ~/.ssh/id_rsa
# Enter the passphrase from above
```

!!! note
    You'll need repeat this step if the agent is restarted

You can check the key by:

```bash
# for private keys
ssh-add -l
# for public keys
ssh-add -L
```

### GPG

Install the [Gnu Privacy Guard](../tools/gpg) (GPG) utilities, and a few other packages 
required for this guide.

```bash
make control-node-gpg
```

- Install a **gpg-agent** lifecycle management scripts using the [UserShellD](../tools/usershelld) framework.
- Generate the gpg keypair with the `There and back again!` as the passphrase

After installation you can open a terminal and type:

```bash
gpg2 --version
```

!!! note
    To properly enable the GnuPG agent functionality, log out of the control node
    and log back in.

You should see something similar to the following.

```bash
gpg (GnuPG) 2.2.0
libgcrypt 1.8.1
```

After the key generation is complete, view the key:

```bash
gpg2 --list-keys
# or
gpg2 -k
```

which should display something similar to the following:

```bash
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
/home/vagrant/.gnupg/pubring.kbx
--------------------------------
pub   rsa2048 2018-01-18 [SC]
      F5522A412095FB5E049DCEC05B289F8626A7F973
uid           [ultimate] bilbo@shire.vil
sub   rsa2048 2018-01-18 [E]
```

