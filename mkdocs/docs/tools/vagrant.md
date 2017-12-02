[Vagrant](https://www.vagrantup.com) is a development automation tool.

!!! note
    Guide version: **2.0.1**

### Check the version

```bash
vagrant version
# or
vagrant --version
```

### Import a box

```bash
vagrant box add --name <name> <path/to/box>
```

Example name:

- `bi/eiab`

### List locally cached boxes

```bash
vagrant box list
```

### Start a machine

```bash
vagrant up
# or
vagrant up <machine name>
```

### Log into a machine

```bash
vagrant ssh
# or
vagrant ssh <machine name>
```

# Reference

- [Project Page](https://www.vagrantup.com)
- [vagrant-hostmanager plugin](https://github.com/devopsgroup-io/vagrant-hostmanager)
