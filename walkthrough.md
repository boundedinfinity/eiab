## Step 1

From the control node spin up:

- 3 operations nodes
- 3 data store nodes
- 3 application nodes

Take note of the IP addresses of those nodes and add them to the
`ansible/inventory.ini` file:

Update the `[ops]`, `[app]`, and `[ds]` sections with your IP addresses.

```ini
[ops]
10.1.1.1
10.1.1.2
10.1.1.3

[app]
10.1.1.4
10.1.1.5
10.1.1.6

[ds]
10.1.1.7
10.1.1.8
10.1.1.9
```

**TODO:** Automate this

## Step 2

Execute ansible playbook to create an `automation` user named `ansible`.
This will remove the `default` account that is created with your cloud based
instances, and replace it with one you can select.

```
make 002-ansible-account
```

**TODO:** Automate ssh host key add

## Step 3

Remove the `default` account not that the new `automation` account has been
created.

```
make 003-default-account
```

## Step 4

Add your custom administrator account by updating the `playbooks/005-admins.yml` file.  Configure the `vars` section to look
somthing like this:

```yml
    vars:
        - admins:
            - jbond
```

**NOTE:** Each tab is 4 spaces.

## Step 5

Provision the administrator accounts.

```
make 005-admins
```

You should now use these to log into the machines.

## Step 6

Install a set of common utilities.  

```
make 006-utilities
```

**NOTE**: If you have specialized utilities for you environment.  You can add them
to the list in the `006-utilities.yml` file.

## Step 7

Provision the [consul]() server nodes.

```
make 007-consul-server
```

This will provision the server nodes one at a time to properly bootstrap
the cluster. Once this step is complete verify by:

```
ssh <operations node>
consul members
```

You should see something similar to the following:

```
Node         Address           Status  Type    Build  Protocol  DC
demo-ops-01  10.1.1.1:8301     alive   server  0.9.2  2         dc1
demo-ops-02  10.1.1.2:8301     alive   server  0.9.2  2         dc1
demo-ops-03  10.1.1.3:8301     alive   server  0.9.2  2         dc1
```

## Step 8

Provision the [consul]() client nodes.

```
make 008-consul-client
```

Once this step is complete verify by:

```
ssh <application or datastore node>
consul members
```

You should see something similar to the following:

```
Node         Address           Status  Type    Build  Protocol  DC
demo-app-01  10.1.1.4:8301     alive   client  0.9.2  2         dc1
demo-app-02  10.1.1.5:8301     alive   client  0.9.2  2         dc1
demo-app-03  10.1.1.6:8301     alive   client  0.9.2  2         dc1
demo-ds-01   10.1.1.7:8301     alive   client  0.9.2  2         dc1
demo-ds-02   10.1.1.8:8301     alive   client  0.9.2  2         dc1
demo-ds-03   10.1.1.9:8301     alive   client  0.9.2  2         dc1
demo-ops-01  10.1.1.1:8301     alive   server  0.9.2  2         dc1
demo-ops-02  10.1.1.2:8301     alive   server  0.9.2  2         dc1
demo-ops-03  10.1.1.3:8301     alive   server  0.9.2  2         dc1
```

## Step 9

Verify that the DNS configuration is working for the nodes by:

```
ssh <application or datastore node>
dig @127.0.0.1 -p 8600 demo-ops-01.node.consul. ANY
```

## Step 10

Provision the [vault]() cluster.  This will install and configure the service,
can configure the service to using the consul cluster as the backend storage.

```
make 010-vault
```

## Step 11

Initialize the vault server.

Check the status of the cluster.

```
ssh <any node>
vault status
```

You should see something similar to this:

```
Error checking seal status: Error making API request.

URL: GET http://127.0.0.1:8200/v1/sys/seal-status
Code: 400. Errors:

* server is not yet initialized
```

Then initialize the cluster.

```
ssh <any node>
vault init -key-shares=2 -key-threshold=2
```

**NOTE**: Save the Initial Root Token and the Unseal Keys

# Step 12

Check the status of the cluster.

```
ssh <any node>
vault status
```

You should see something similar to the following:

```
Sealed: true
Key Shares: 2
Key Threshold: 2
Unseal Progress: 0
Unseal Nonce:
Version: 0.8.1

High-Availability Enabled: true
	Mode: sealed
```

Unseal the vault.

```
ssh <any node>

# First unseal
vault unseal
# enter one of the unseal keys


# Second unseal
vault unseal
# enter the other unseal key
```

Check the status of the cluster.

```
ssh <any node>
vault status
```

You should see something similar to the following:

```
Sealed: false
Key Shares: 2
Key Threshold: 2
Unseal Progress: 0
Unseal Nonce:
Version: 0.8.1
Cluster Name: vault-cluster-xxxxxxxx
Cluster ID: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

High-Availability Enabled: true
	Mode: active
	Leader Cluster Address: https://127.0.0.1:8201
```

**NOTE:** The unseal process must point to the same vault instance

### Step 13

Check the status of the vault service on the consul cluster:

```
ssh <any node>
curl http://$CONSUL_ADDR/v1/catalog/services | jq
```


vault auth
- enter root token
curl vault.service.consul
