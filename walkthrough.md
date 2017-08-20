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


curl vault.service.consul
