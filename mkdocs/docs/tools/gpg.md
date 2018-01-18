[Gnu Privacy Guard](https://www.gnupg.org) (GPG) is a encryption utility.

!!! note
    Guide version: **2.0.22**

### Check the version

```bash
gpg --version
```

### Generate a key

```bash
gpg --gen-key
```

### List public keys

```bash
gpg -k
# or 
gpg --list-keys
# or
gpg --list-keys --with-colons
```

### List secret keys

```bash
gpg -K
# or 
gpg --list-secret-keys
```

### Export a key in ASCII format

```bash
gpg --export <key ID> | base64
# e.g.:
gpg --export bilbo@shire.vil | base64
```

### Run the agent

```bash
gpg-agent --daemon
```

### Kill the agent

```bash
pkill gpg-agent
```

### Encrypt a file

```bash
gpg --recipient <key ID> --output <output file> --encrypt <input file>
# e.g.:
gpg --recipient bilbo@shire.vil --output output.txt.gpg --encrypt input.txt 
```

### Decrypt a file

```bash
gpg --output <output file> --decrypt <input file>
# e.g.:
gpg --output output.txt --decrypt input.txt.gpg
```

### Generate a unattended key pair

```
gpg2 --batch --passphrase '<pass phrase>'  --quick-generate-key '<user ID>' <algorithm> <usage> <expire>
```

# Reference

- [Project Page](https://www.gnupg.org)
    - [Invoking GPG-AGENT](https://gnupg.org/documentation/manuals/gnupg/#toc-Invoking-GPG_002dAGENT-1)
    - [Unattended key generation](https://www.gnupg.org/documentation/manuals/gnupg/Unattended-GPG-key-generation.html)
- [Rng-tools](https://wiki.archlinux.org/index.php/Rng-tools)
- Articles
    - [CREATING THE PERFECT GPG KEYPAIR](https://alexcabal.com/creating-the-perfect-gpg-keypair)
    - [Generating More Secure GPG Keys: A Step-by-Step Guide](https://spin.atomicobject.com/2013/11/24/secure-gpg-keys-guide)
    - [How to use a GPG key for SSH authentication](https://www.linode.com/docs/security/gpg-key-for-ssh-authentication)
