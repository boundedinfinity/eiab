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

### Install plugin

```bash
vagrant plugin install <plugin name>
```

### List available plugins

```bash
gem list --remote vagrant-
```

### Update the host file

```bash
vagrant hostmanager
```

Or browse to the [Vagrant plugins wiki](https://github.com/hashicorp/vagrant/wiki/Available-Vagrant-Plugins).

# Reference

- [Project Page](https://www.vagrantup.com)
- Plugins
    - [vagrant-hostmanager plugin](https://github.com/devopsgroup-io/vagrant-hostmanager)
