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

Configure the clock via the [Network Time Protocol](http://www.ntp.org).  This is needs to stop
ansible errors related to file timestamps.

```bash
make control-node-ntp
```

### Ansible roles

Install any required third party roles from [Ansible Galaxy](https://galaxy.ansible.com).

```bash
make control-node-roles
```

### GPG

Install the [Gnu Privacy Guard](../tools/gpg) (GPG) utilities, and a few other packages 
required for this guide.

```bash
make control-node-gpg
```

After installation you can open a terminal and type:

```bash
gpg --version
```

You should see something similar to the following.

```bash
gpg (GnuPG) 2.0.22
libgcrypt 1.5.3
...
...
...
```

Help generate some random entropy for key generation.  

!!! note
    This step is mainly required to generate entropy while running inside a VM.  This shouldn't 
    be necessary when running on a physical computer.


```bash
sudo rngd -r /dev/urandom
```

Then generate a key:

```bash
gpg --gen-key
```

Using the following parameters:

- Key type: `RSA and RSA (default)`
- Key lenght: `4096`
- Expire Date: `0`
- Real name: `Frodo Baggins`
- Email: `frodo@shire.village`
- Comment: hit enter to leave blank
- Passphrase: `aaaa1234`

After the key generation is complete, view the key:

```bash
gpg --list-keys
# or
gpg -k
```

which should display something similar to the following:

```bash
/home/vagrant/.gnupg/pubring.gpg
--------------------------------
pub   4096R/C00B50B8 2017-12-02
uid                  Frodo Baggins <frodo@shire.village>
sub   4096R/45FB4738 2017-12-02
```


