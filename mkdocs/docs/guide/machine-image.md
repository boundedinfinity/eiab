The build process relies on the [boxcutter centos](https://github.com/boxcutter/centos) build configuration project.

The following series of command must be ran from the `$EIAB_DIR/packer`:

```bash
cd $EIAB_DIR/packer
```

Download the system by:

```bash
git clone https://github.com/boxcutter/centos.git boxcutter-centos
```

Build the machine image that will be used for this guide.

```bash
packer build -only=virtualbox-iso -var-file=../eiab-var.json centos.json
```

This step may take quite a while to finish.  It should end with something similar to the following:

```bash
Build 'virtualbox-iso' finished.

==> Builds finished. The artifacts of successful builds are:
--> virtualbox-iso: 'virtualbox' provider box: box/virtualbox/centos7-0.0.99.box
```

This will perform the following:

- Download the and verify the [CentOS](https://www.centos.org) ISO and verify the image against the configure checksum
- Creates a [VirtualBox](https://www.virtualbox.org) image using the [VirtualBox Builder](https://www.packer.io/docs/builders/virtualbox.html)
- Create a local [kickstart](http://pykickstart.readthedocs.io/en/latest/kickstart-docs.html) environment, and perform the OS installation
- Provision the necessary [VirtualBox](https://www.virtualbox.org) configuration
- Converts the image to a [Vagrant Box](https://www.vagrantup.com/docs/boxes.html) using the [Vagrant Post-Processor](https://www.packer.io/docs/post-processors/vagrant.html) 


Import the box into the local [Vagrant](https://www.vagrantup.com) cache:

```bash
vagrant box add --name bi/eiab boxcutter-centos/box/virtualbox/centos-7.4.box
```

Next list the boxes.

```bash
vagrant box list
```

You should see a line similar to the following:

```bash
...
...
bi/eiab                                 (virtualbox, 0)
...
...
```
