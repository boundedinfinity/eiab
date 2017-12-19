[OpenSSH](https://www.openssh.com) secure remote connection utility.

!!! note
    Guide version: **7.4**

### Check the version

```bash
ssh -V
```

### Add key pair cache

```bash
ssh-add ~/.ssh/id_rsa
```

### List private keys in cache

```bash
ssh-add -l
```

### List public keys in cache

```bash
ssh-add -L
```

### Run the agent

```bash
ssh-agent -s
```

### Kill the agent

```bash
pkill ssh-agent
```

# Reference

- [Project page](https://www.openssh.com)
