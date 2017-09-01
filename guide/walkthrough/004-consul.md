# Consul provisioning

Configure a [Consul](https://www.consul.io) cluster.

### TODO
- Configure web UI
- Configure SSL

## Step 1

Log into the control machine and change to the directory with the
Makefile and ansible configuration

```
vagrant ssh control
cd /vagrant
```

## Step 2

Create the 3 node `consul` server ring.  This provisions 3 `consul` agents in server mode on the 3 `ops` nodes.

```
make 003-consul-server
```

## Step 3

To verify the cluster log into one of the ops nodes and list the `consul` cluster members.

```
vagrant ssh ops00
consul members
```

The output should be similar to the following:

```
Node   Address         Status  Type    Build  Protocol  DC
ops00  10.0.0.10:8301  alive   server  0.9.2  2         dc1
ops01  10.0.0.11:8301  alive   server  0.9.2  2         dc1
ops02  10.0.0.12:8301  alive   server  0.9.2  2         dc1
```

## Step 4

Provision `consul` clients on all other nodes.

```
make 003-consul-client
```

## Step 5

To verify the cluster log into one of the ops nodes and list the `consul` cluster members.

```
vagrant ssh ops00
consul members
```

The output should be similar to the following:

```
Node   Address         Status  Type    Build  Protocol  DC
app00  10.0.0.20:8301  alive   client  0.9.2  2         dc1
app01  10.0.0.21:8301  alive   client  0.9.2  2         dc1
app02  10.0.0.22:8301  alive   client  0.9.2  2         dc1
ds00   10.0.0.30:8301  alive   client  0.9.2  2         dc1
ds01   10.0.0.31:8301  alive   client  0.9.2  2         dc1
ds02   10.0.0.32:8301  alive   client  0.9.2  2         dc1
ops00  10.0.0.10:8301  alive   server  0.9.2  2         dc1
ops01  10.0.0.11:8301  alive   server  0.9.2  2         dc1
ops02  10.0.0.12:8301  alive   server  0.9.2  2         dc1
```

## Step 6

Verify DNS queries are working.

```
vagrant ssh ops00
dig @127.0.0.1 -p 8600 ops00.node.consul. ANY
```

The output should contain an `ANSWER SECTION` with output similar to the following:

```
;; ANSWER SECTION:
ops00.node.consul.	0	IN	A	10.0.0.10
```

## Step 7

Configure the local DNS resolver to query consul first in the DNS query chain.

```
make 003-dns
```
