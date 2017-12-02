# File server

Configuring the file server

**TODO:**
- configure TLS
- /etc/nginx/conf.d not working


## Step 1

Log into the control machine and change to the directory with the
Makefile and ansible configuration

```
vagrant ssh control
cd /vagrant
```

## Step 2

Provision the file server

```
make 003-fileserver
```
