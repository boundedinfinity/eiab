### GPG and pass

```
cd $EIAB/ansible
make gpg
```

install gpg and pass

```
gpg --version
gpg (GnuPG) 2.2.7
...
```

```
pass --version
pass --version
...
=                  v1.7.1                  =
...
```

### Create your credentials

```
gpg --batch --passphrase 'password' --quick-generate-key 'someone@somewhere.org' default default none
...
gpg: key A2ED98A3F5D1D548 marked as ultimately trusted
gpg: revocation certificate stored as '/Users/someone/.gnupg/openpgp-revocs.d/AC3DC669B06EC2DD872EC95AA2ED98A3F5D1D548.rev'
...
```

Then list your keys:

```
gpg --list-keys
...
uid           [ultimate] someone@somewhere.org
...
```

Create your store:

```
pass init someone@somewhere.org
```

Add the credentials for the Raspberry PI

```
pass insert eiab/rpi/pi
```

When prompted for the password type: `raspberry`.

Check the store:

```
pass
Password Store
└── eiab
    └── rpi
        └── pi
```

Get the password:

```
pass eiab/rpi/pi
raspberry
```

Test with ansible

```
make macos-pass-test
...
    "msg": "raspberry"
```
