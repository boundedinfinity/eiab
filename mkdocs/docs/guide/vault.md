Configure a [Vault](https://www.vaultproject.io) cluster.

!!! TODO
    - Configure HA
    - Configure SSL

## Server

Provision the `vault` server configured to use the `consul` cluster as the backing store.

```bash
make vault-server
```

Use `consul` to discover the location of the `vault` server:

```bash
http -b $CONSUL_ADDR/v1/catalog/service/vault | jq -r '.[0].Address'
```

!!! note 
    The `$CONSUL_ADDR` variable was created as a part of this tutorial, and is not a 
    part of the `consul` installation.

The output should be something similar to the following:

```bash
10.0.0.10
```

!!! note
    Use the ansible `inventory.ini` file to verify the name of this server.
    For this demo is should be the `ops00` server.

In a separate terminal log into the vault server and check the status.

```bash
vagrant ssh ops00
vault status
```

The output should be something similar to the following:

```bash
Error checking seal status: Error making API request.

URL: GET http://127.0.0.1:8200/v1/sys/seal-status
Code: 400. Errors:

* server is not yet initialized
```

Initialize the vault server:

```bash
vault init
```

you should seem something similar to the following:

```bash
Unseal Key 1: QdrzwsZb4p92a4t9y+78mhrMniS2kmILdEqbDOPocxdf
Unseal Key 2: 8SwZu0pexmTzR7PpN9oSIGqMlKMRUFFlqNEZs6Cv6Rew
Unseal Key 3: bgX0HBdqAJY4gWWfGBm0jOqpigFtQf1uNawpQbsVWjWb
Unseal Key 4: 0xqKSMPoXNRwe6YAo+etJ6dhgMEMICwW9vBEF/eyZi1F
Unseal Key 5: TiN7vItPO/18ovDWVdDbgEakLnru+3EuewYx5gb64eBM
Initial Root Token: 4538885a-92ea-5870-8ee0-cfc33cb2e44f
```

Next you'll need to store these keys in a secure fashion:

```bash
pass init bilbo@shire.vil
```

which is the name of the GPG key, then you save these in a secure fashion:

```
pass vault/root-token
# enter the Initial Root Token value
pass insert vault/unseal-1
# enter the Unseal Key 1 value
```

Then repeat this process for the rest of these unseal keys.

You can now access these keys:

```
pass vault/unseal-3
bgX0HBdqAJY4gWWfGBm0jOqpigFtQf1uNawpQbsVWjWb
```

Now if you check the state:

```bash
vagrant ssh ops00
vault status
```

You should see something similar to the following:

```bash
Type: shamir
Sealed: true
Key Shares: 5
Key Threshold: 3
Unseal Progress: 0
Unseal Nonce:
Version: 0.9.0

High-Availability Enabled: true
	Mode: sealed
```

To unseal the vault run the following:

```bash
vault unseal
```

Extract the key vaules using the **pass** command frmo above, and repeat three times.
On the 3rd run, the output should be similar to the following:

```bash
Sealed: false
Key Shares: 5
Key Threshold: 3
Unseal Progress: 0
Unseal Nonce:
```

Note the the `Sealed` line is `false`.  Then check the status of the vault cluster once more:

```bash
vault status
```

which should produce output similar to the following:

```bash
Sealed: false
Key Shares: 5
Key Threshold: 3
Unseal Progress: 0
Unseal Nonce:
[ansible@ops00 ~]$ vault status
Type: shamir
Sealed: false
Key Shares: 5
Key Threshold: 3
Unseal Progress: 0
Unseal Nonce:
Version: 0.9.0
Cluster Name: vault-cluster-8f1d1c07
Cluster ID: c25d0d40-70b8-1fed-decb-a2e9b88e2104

High-Availability Enabled: true
	Mode: active
	Leader Cluster Address: https://10.0.0.10:8201
```

The next step is to authentication your session with the server:

```bash
pass vault/root-token
# copy the token
vault auth
# enter the token
```

After you enter the value of the `Initial Root Token`, which should produce 
output similar to the following:

```bash
Successfully authenticated! You are now logged in.
token: 4538885a-92ea-5870-8ee0-cfc33cb2e44f
token_duration: 0
token_policies: [root]
```

To test the server, try adding your first secret:

```bash
vault write secret/hello value=world
```

which should produce output similar to the following:

```bash
Success! Data written to: secret/hello
```

Then read the secret:

```bash
vault read secret/hello
```

which should produce output similar to the following:

```bash
Key             	Value
---             	-----
refresh_interval	768h0m0s
value           	world
```
