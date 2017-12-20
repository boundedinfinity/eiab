[Consul](https://www.consul.io) a service discovery and monitoring system.


### Check system service status

```bash
systemctl status consul
```

### Restart system service

```bash
systemctl restart consul
```

### List services

```bash
http $CONSUL_ADDR/v1/catalog/services
```

### Details of a service

```bash
http $CONSUL_ADDR/v1/catalog/service/<service name>
```

### Deregister a service

```bash
http PUT $CONSUL_ADDR/v1/agent/service/deregister/<service ID>
```

and if that doesn't work:

```bash
http $CONSUL_ADDR/v1/catalog/service/<service name | jq --compact-output '.[] | {Datacenter:.Datacenter, Node:.Node,ServiceID:.ServiceID}'

echo '{"Datacenter":"dc1","Node":"service.node.address","ServiceID":"4e266b3b-b201-49f9-9bd5-e0e7262324d8:10005"}' | http PUT $CONSUL_ADDR/v1/catalog/deregister
```

### DNS service query (A record)

```bash
dig <service name>.service.consul
```

### DNS service query (SRV record)

```bash
dig <service name>.service.consul SRV
```

### DNS service query with tag (A record)

```bash
dig dev.cassandra.service.consul
```
