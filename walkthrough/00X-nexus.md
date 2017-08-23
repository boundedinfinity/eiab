Credentials:
- admin
- admin123

Repo types:
    - proxy: pull from cache, if not found pull from remote
    - hosted: authoritative repo
    - order search through a group of proxy and/or hosted repos

curl -v -u admin:admin123 'http://10.0.0.12:8081/service/siesta/rest/v1/script'
http -a admin:admin123 http://10.0.0.12:8081/service/siesta/rest/v1/script

http://10.0.0.12:8081/repository/releases.hashicorp.com/consul/0.9.1/consul_0.9.1_SHA256SUMS
http://10.0.0.12:8081/repository/files/consul/0.9.1/consul_0.9.1_SHA256SUMS.sig

http -a admin:admin123 POST http://10.0.0.12:8081/service/siesta/rest/v1/script/raw_proxy/run Content-Type:text/plain body='{ "name": "releases.hashicorp.com2", "remoteUrl": "https://releases.hashicorp.com" }'

http -a admin:admin123 POST http://10.0.0.12:8081/service/siesta/rest/v1/script/raw_proxy/run body='{ "name": "releases.hashicorp.com2", "remoteUrl": "https://releases.hashicorp.com" }'

- Repositories information
    - raw-proxy
        - name: releases.hashicorp.com
        - url: http://releases.hashicorp.com
        - online: true
        - st
        - max component age: 262800
        - max metadata age: 262800
    - group
        - name: files
        - members:
            - releases.hashicorp.com


Reference:
    - https://help.sonatype.com/display/NXRM3/REST+and+Integration+API
    - http://docs.ansible.com/ansible/latest/uri_module.html
    - http://docs.ansible.com/ansible/latest/playbooks_lookups.html
    - https://httpie.org/doc#basic-auth
    - https://github.com/sonatype/nexus-book-examples/tree/nexus-3.x
