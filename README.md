# Nomad Ansible Role
[![Build Status](https://travis-ci.org/bdclark/ansible-nomad.svg?branch=master)](https://travis-ci.org/bdclark/ansible-nomad)

Installs and configures HashiCorp [Nomad][1].

Requirements
------------
This role is being tested using Ansible 2.6, 2.7, 2.8 on the following operating systems:

- Ubuntu 16.04
- Ubuntu 18.04
- Amazon Linux 2
- Centos 7.x

Other distributions/versions may work, providing it uses systemd.  YMMV.

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml) for a list and description of
variables used in this role.

Example Playbook
----------------

```yaml
# <ansible_base_dir>/group_vars/all
---
nomad_general_config:
  region: us
  datacenter: us-east
  bind_addr: 0.0.0.0
  advertise:
    rpc: "{{ ansible_default_ipv4.address }}:4647"
    serf: "{{ ansible_default_ipv4.address }}:4648"
  consul:
    token: D8D36BE5-8803-430C-8FBA-6F4FB032CB5B
nomad_server_config:
  bootstrap_expect: 3
nomad_client_config:
  reserved:
    cpu: 500
    memory: 512
    disk: 1024
```

```yaml
# <ansible_base_dir>/playbooks/nomad
---
- hosts: nomad_servers
  roles:
    - role: nomad
      nomad_server_enabled: true

- hosts: nomad_clients
  roles:
    - role: nomad
      nomad_user_managed: false
      nomad_user: root
      nomad_group: root
```

[1]: https://www.nomadproject.io/
