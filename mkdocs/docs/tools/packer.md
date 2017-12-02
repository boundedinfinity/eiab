[Packer](https://www.packer.io) is a build automation tool that manages machine images.

!!! note
    Guide version: **1.1.2**

### Get the version

```bash
packer version
```

### Build an image

```bash
packer build -only=virtualbox-iso -var-file=centos7.json centos.json
...
...
...
==> Builds finished. The artifacts of successful builds are:
--> virtualbox-iso: 'virtualbox' provider box: box/virtualbox/centos7-0.0.99.box
```

# Reference

- [Project page](https://www.packer.io)
    - Documentation
        - [CLI](https://www.packer.io/docs/commands/index.html)
- [boxcutter/centos](https://github.com/boxcutter/centos)
