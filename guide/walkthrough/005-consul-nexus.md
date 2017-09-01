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

Register the file service as a `consul` service

```
make 005-consul-fileserver
```

## Step 3

Check the service.


Check the service endpoint.

```
vagrant ssh <any node>
http $CONSUL_ADDR/v1/catalog/service/nexus | jq
```

The output should be something similar to the following:

```json
[
    {
        "ID": "dafebce0-40d3-3dd4-0e48-4c853a9e72a9",
        "Node": "ops02",
        "Address": "10.0.0.12",
        "Datacenter": "dc1",
        "TaggedAddresses": {
            "lan": "10.0.0.12",
            "wan": "10.0.0.12"
        },
        "NodeMeta": {},
        "ServiceID": "nexus",
        "ServiceName": "nexus",
        "ServiceTags": [],
        "ServiceAddress": "10.0.0.12",
        "ServicePort": 8081,
        "ServiceEnableTagOverride": false,
        "CreateIndex": 313,
        "ModifyIndex": 315
  }
]
```

Check the service DNS entry.

```
dig fileserver.service.consul SRV
```

The output should be something similar to the following:

```
...
;; ANSWER SECTION:
nexus.service.consul. 0	IN	SRV	1 1 8081 ops01.node.dc1.consul.
...
```
