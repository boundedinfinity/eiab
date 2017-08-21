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
curl -s $CONSUL_ADDR/v1/catalog/service/fileserver | jq
```

The output should be something similar to the following:

```json
[
    {
        "ID": "9635634d-2aaa-2c3f-7996-e0a93b232efd",
        "Node": "ops01",
        "Address": "10.0.0.11",
        "Datacenter": "dc1",
        "TaggedAddresses": {
            "lan": "10.0.0.11",
            "wan": "10.0.0.11"
        },
        "NodeMeta": {},
        "ServiceID": "fileserver",
        "ServiceName": "fileserver",
        "ServiceTags": [],
        "ServiceAddress": "",
        "ServicePort": 80,
        "ServiceEnableTagOverride": false,
        "CreateIndex": 525,
        "ModifyIndex": 525
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
fileserver.service.consul. 0	IN	SRV	1 1 80 ops01.node.dc1.consul.
...
```
