Common Configuration for all nodes

### Clock

Configure the clock via the [Network Time Protocol](http://www.ntp.org).  This will fix 
clock skew errors.

```bash
make all-nodes-ntp
```

!!! note
    TODO: Internal NTP master

### Common utilities

Install a number of helpful utilities

```bash
make all-nodes-utilities
```
