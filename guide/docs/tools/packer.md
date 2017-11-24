Packer
############################################################

Machine image automation tool.


```bash
packer build -only=virtualbox-iso -var-file=centos7.json centos.json
...
==> Builds finished. The artifacts of successful builds are:
--> virtualbox-iso: 'virtualbox' provider box: box/virtualbox/centos7-0.0.99.box
```

Reference

- [Packer homepage](https://www.packer.io)
- [boxcutter/centos](https://github.com/boxcutter/centos)
