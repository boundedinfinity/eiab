### Packer

Install the [Packer](../tools/packer) utility. 

```bash
brew install packer
```

Once the installation is complete, check the installation.

```bash
packer version
```

which should return something similar to:

```
Packer v1.1.2
```

### VirtualBox


Install the [VirtualBox](../tools/virtualbox) virtualization
system.  This will allow you to provision virtualized guest operating system.

After installation you can open a terminal and type:

```bash
brew cask install virtualbox
```

Once the installation is complete, check the installation.

```bash
vboxmanage --version
```

which should return something similar to:

```
5.2.0r118431
```

### Vagrant

Install the [Vagrant](../tools/vagrant) virtualization managment
and workflow tools.  This is manage the provisioning of the virtualized guest
systems used in this tutorial.

After installation you can open a terminal and type:

```bash
brew cask install vagrant
```

Once the installation is complete, check the installation.

```bash
vagrant version
```

which should return something similar to:

```
Installed Version: 2.0.1
Latest Version: 2.0.1
```
