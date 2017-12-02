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
```

### List secret keys

```bash
gpg -K
# or 
gpg --list-secret-keys
```

Export a key in ASCII format:

```bash
gpg --export <email address> | base64
```

# Reference

- [Project Page](https://www.gnupg.org)
    - [Invoking GPG-AGENT](https://gnupg.org/documentation/manuals/gnupg/#toc-Invoking-GPG_002dAGENT-1)
    - [Unattended key generation](https://www.gnupg.org/documentation/manuals/gnupg/Unattended-GPG-key-generation.html)
- [Rng-tools](https://wiki.archlinux.org/index.php/Rng-tools)
- Articles
    - [CREATING THE PERFECT GPG KEYPAIR](https://alexcabal.com/creating-the-perfect-gpg-keypair)
    - [Generating More Secure GPG Keys: A Step-by-Step Guide](https://spin.atomicobject.com/2013/11/24/secure-gpg-keys-guide)
