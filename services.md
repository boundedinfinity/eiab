# Service Method of Procedure (MOP)

This will be used to create an open source dynamic micro-service architecture.
This infrastructure should fulfill the following constraints:

- Detect code changes
  - Build a copy in the CI system
  - Update the Version information
  - Run automated test
  - Support feature branch
  - Deploy to a development environment (a standard environment or create a dynamically created one)
- Manual step to promote to QA
- Services deployment should:
  - Allocate deployment bundle
  - Configure host, DNS, ports, discovery systems, etc...
  - Configure monitoring
  - Configure security
- Provide proxy and load balancing
- Provide API Management
- Provide inventory system available via API
- Management dashboard to point to all these services

- Software:
  - Source control Repository: [git][https://git-scm.com]
  - Issue management: [GitLab](https://about.gitlab.com)
  - Continuous Integration: [GitLab CI](https://about.gitlab.com/features/gitlab-ci-cd)
  - Service Discovery, Monitoring, and DNS: [Consul](https://www.consul.io)
  - Programatic Credentials Management: [Vault](https://www.vaultproject.io)
  - API management, proxying, load balancing [Kong](https://getkong.org)
  - Single Sign On [Keyclock][http://www.keycloak.org]
    - [WildFly](http://wildfly.org)
  - Configuration Management: [Ansible](https://www.ansible.com)
  - Binary Repository: [Nexus](https://www.sonatype.com/nexus-repository-oss)
  - Datastores
    - [PostgreSQL](https://www.postgresql.org)
      - Required by:
        - Keyclock
  - Caching
    - [Varnish](https://varnish-cache.org)
  - Full DNS: [PowerDNS](https://www.powerdns.com)


# MOP

## Definitions

- Control node: The machine from which to drive the whole process. This
  is likely a workstation or local VM environment like vagrant or Docker.
- Database nodes: All nodes that have stateful data.  These are likely machines
  that house databases (PostgreSQL, ElasticSearch) or queueing systems (Redis).
- Operational nodes: Contains a management systems (Repositories, CI, etc...)
- Application nodes: All nodes that contain the application

## Assumptions

  - The user has a generated ssh key pair
  - Connectivity to all nodes from the control node
  - The nodes have ssh enabled
  - The cloud (or default) account has sudo privileges

## Manual:

### All nodes
 - Copy user's ssh public key to the cloud user account
 - Configure ansible account
