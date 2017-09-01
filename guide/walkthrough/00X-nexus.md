# Nexus

Install binary repo

### Step 1

make 003-nexus-server

### Step 2

Browse to http://10.0.0.12:8081/
- username: admin
- password: admin123

Repo types:
    - proxy: pull from cache, if not found pull from remote
    - hosted: authoritative repo
    - order search through a group of proxy and/or hosted repos

### Step 3

Demo setting up raw repo

### Step 3

Demo setting up yum repo

### Step 4

make 003-nexus-repo

Installs proxies for the following:

- Raw proxies
    - https://releases.hashicorp.com
    - https://download.sonatype.com
- Yum proxies
    - centos-base-7-x86_64
    - epel-7-x86_64
    

Check repos in UI


### Step 5

Configure YUM to point to nexus

make 002-yum

### Step 6

TODO:
    - re-download java and nexus archive to force into cache

https://pip.pypa.io/en/stable/user_guide/#config-file
https://help.sonatype.com/display/NXRM3/PyPI+Repositories

List
http -a admin:admin123 http://10.0.0.12:8081/service/siesta/rest/v1/script
Delete
http -a admin:admin123 DELETE http://10.0.0.12:8081/service/siesta/rest/v1/script/raw_proxy

http://10.0.0.12:8081/repository/releases.hashicorp.com/consul/0.9.1/consul_0.9.1_SHA256SUMS
http://10.0.0.12:8081/repository/releases.hashicorp.com3/consul/0.9.1/consul_0.9.1_SHA256SUMS
http://10.0.0.12:8081/repository/files/consul/0.9.1/consul_0.9.1_SHA256SUMS.sig

Use custom facts for consul lookups

http -a admin:admin123 POST http://10.0.0.12:8081/service/siesta/rest/v1/script/list_repo/run Content-Type:text/plain

http -a admin:admin123 POST http://10.0.0.12:8081/service/siesta/rest/v1/script/create_raw_proxy/run Content-Type:text/plain body='{ "name": "test1", "remote_url": "https://releases.hashicorp.com" }'


- Repositories information
    - raw
        - proxy
            - name
            - remote_url
        - hosted
            - name
    - yum
        - proxy
            - name
            - remote_storage



System wide configuration change for YUM
- centos base
    - name: centos-base-7-x86_64
    - remote_storage: http://mirrorlist.centos.org/?release=7&arch=x86_64&repo=os
    - remote_storage: http://mirror.centos.org/centos/7/os/x86_64/

- epel base
    - name: Extra Packages for Enterprise Linux 7 - x86_64
    - name: epel-7-x86_64
    - remote_storage: http://download.fedoraproject.org/pub/epel/7/$basearch
    - remote_storage: http://download.fedoraproject.org/pub/epel/7/x86_64/

http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra
http://mirrorlist.centos.org/?release=7&arch=x86_64&repo=os

http://mirror.centos.org/centos/$releasever/os/$basearch/
http://mirror.centos.org/centos/7/os/x86_64/

[centos]
name=centos
baseurl=http://10.0.0.12:8081/repository/centos-base-7-x86_64/
gpgcheck=0

[epel]
name=epel
baseurl=http://10.0.0.12:8081/repository/epel-7-x86_64/
gpgcheck=0

http://10.0.0.12:8081/repository/epel-7-x86_64/


Maven system wide change



Reference:
    - https://help.sonatype.com/display/NXRM3/REST+and+Integration+API
    - http://docs.ansible.com/ansible/latest/uri_module.html
    - http://docs.ansible.com/ansible/latest/playbooks_lookups.html
    - https://httpie.org/doc#basic-auth
    - https://github.com/sonatype/nexus-book-examples/tree/nexus-3.x
    - http://blog.toast38coza.me/custom-ansible-module-hello-world/
    - https://github.com/cmprescott/ansible-xml
    - http://maven.apache.org/guides/mini/guide-proxies.html
