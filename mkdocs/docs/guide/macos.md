Currently this guide will be focused on a macOS worksation with the following minimum requirements:

- macOS High Sierra - version 10.13.5

```bash
system_profiler SPSoftwareDataType
Software:

    System Software Overview:

      System Version: macOS 10.13.5 (17F77)
...
```

### Xcode


```
xcode-select --print-path
```

the return value will be 2 if they do NOT exist, and 0 if they do (as well as the directory).

```
xcode-select --install
```

### Make

```
make --version
```

### Ansible

```
make ansible
```

### Homebrew


This first step is to install the [Homebrew](../tools/homebrew) package 
management system.

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

!!! note
    This command assume that [Ruby](../tools/ruby) programming language, the [curl](../tool/curl) 
    URL command line client, and the [Make](../tools/make) build utilty are installed.
    
    These tools should be installed on the default macOS operating system.

Once the installation is complete, check the installation.

```bash
brew --version
```

which should return something similar to:

```
Homebrew 1.3.8
Homebrew/homebrew-core (git revision eef61; last commit 2017-12-01)
```

Homebrew Cask
-------------

Install the [Homebrew Cask](../tools/homebrew) extention. This enables additional package needed for this guide.

```bash
brew tap caskroom/cask
```

Now that that package management utility is installed, it's time to install the tools necessary to build the rest of the sytem.

Packer
-------------

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

VirtualBox
-------------

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

Vagrant
-------------

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

Git
-------------

Install the [Git](../tools/git) source control utility. 

```bash
brew install git
```

Once the installation is complete, check the installation.

```bash
git --version
```

which should return something similar to:

```
git version 2.15.1
```
