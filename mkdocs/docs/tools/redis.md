### Start the CLI

```bash
redis-cli
```

### List keys

```bash
keys *
# or
keys '*'
```

### Length of a list

```bash
llen <key name>
```

### Monitor queue lenth (list and set)

```bash
while true; do for k in $(redis-cli keys "*"); do case $(redis-cli type $k) in list) echo -n "list[$k]: "; eval "redis-cli llen $k" ;; set) echo -n "set[$k]: "; eval "redis-cli scard $k" ;; esac; done; sleep 1; clear; done
```

# Reference

- [Redis](https://redis.io)
