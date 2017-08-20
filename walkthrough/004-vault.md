# Vault provisioning

Configure a [Vault](https://www.vaultproject.io) cluster.

### TODO
- Configure HA
- Configure SSL

## Step 1

Log into the control machine and change to the directory with the
Makefile and ansible configuration

```
vagrant ssh control
cd /vagrant
```

## Step 2

Provision the `vault` server configured to use the `consul` cluster as the backing store.

```
make 004-vault-server
```

## Step 3

Use `consul` to discover the location of the `vault` server:

```
dig vault.service.consul
curl -s $CONSUL_ADDR/v1/catalog/service/vault | jq -r '.[0].Address'
```

**NOTE:** The `$CONSUL_ADDR` variable was created as a part of this tutorial, and is not a part of the `consul` installation.

The output should be something similar to the following:

```
10.0.0.10
```

Use the ansible `inventory.ini` file to discover the name of this server.

## Step 4 

Log into the vault server and check the status.

```
vagrant ssh ops00
vault status
```

The output should be something similar to the following:

```
Error checking seal status: Error making API request.

URL: GET http://127.0.0.1:8200/v1/sys/seal-status
Code: 400. Errors:

* server is not yet initialized
```

## Step 5 

Initialize the vault server:

```
vault init
```

**VERY IMPORTANT NOTE**: Save the Initial Root Token and the Unseal Keys

### Step 6

Unseal vault

Run the following 3 times using a different unseal key for each run:

```
vault unseal
```

On the 3rd run, the output should be similar to the following:

```
Sealed: false
Key Shares: 5
Key Threshold: 3
Unseal Progress: 0
Unseal Nonce:
```

Note the the `Sealed` line is `false`.  Then check the status of the vault cluster once more:

```
vault status
```

which should produce output similar to the following:

```
vault status
Sealed: false
Key Shares: 5
Key Threshold: 3
Unseal Progress: 0
Unseal Nonce:
Version: 0.8.1
Cluster Name: vault-cluster-3a275180
Cluster ID: 513bcde4-9771-cbae-7203-385c1a221f3e

High-Availability Enabled: true
	Mode: active
	Leader Cluster Address: https://10.0.0.10:8201
```

### Step 7

Authenticate with the vault server:

```
vault auth
```

Enter the value of the `Initial Root Token`, which should produce output similar to the following:

```
Successfully authenticated! You are now logged in.
```

### Step 8

Now create your first secret:

```
vault write secret/hello value=world
```

which should produce output similar to the following:

```
Success! Data written to: secret/hello
```

Then read the secret:

```
vault read secret/hello
```

which should produce output similar to the following:

```
Key             	Value
---             	-----
refresh_interval	768h0m0s
value           	world
```
