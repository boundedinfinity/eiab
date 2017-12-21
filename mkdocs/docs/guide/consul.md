# Consul provisioning

Configure a [Consul](https://www.consul.io) cluster.  The cluster is broken down to the **server**
nodes and the **client** or **agent** nodes.

!!! TODO
        - Configure web UI
        - Configure SSL

### Server

Create the 3 node `consul` server ring.  This provisions 3 `consul` agents in server mode 
on the 3 `ops` nodes.

```bash
make consul-server
```

To verify the cluster log into one of the ops nodes and list the `consul` cluster members.

```bash
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

### Client

Provision `consul` clients on all other nodes (including the control node).

```bash
make consul-client
```

To verify the cluster log into one of the ops nodes and list the `consul` cluster members.

```bash
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

Verify DNS queries are working.

```bash
dig @127.0.0.1 -p 8600 ops00.node.consul. ANY
```

The output should contain an `ANSWER SECTION` with output similar to the following:

```bash
;; ANSWER SECTION:
ops00.node.consul.	0	IN	A	10.0.0.10
```

This also configures a local DNS resolver to query consul first in the DNS query 
chain. 

```bash
dig ops00.node.consul
```

The output should contain an `ANSWER SECTION` with output similar to the following:

```bash
;; ANSWER SECTION:
ops00.node.consul.	0	IN	A	10.0.0.10
```

!!! note
    To properly enable the Consul global variables.
