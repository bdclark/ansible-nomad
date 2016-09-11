# nomad

Install and configure Nomad

Requirements
------------

TODO: Add role requirements.

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml) for a list and description of
variables used in this role.

Example Playbook
----------------

TODO: Add example playbook(s).

```yaml
---
nomad_general_config:
  region: us
  datacenter: us-east
  bind_addr: 0.0.0.0
  advertise:
    rpc: "{{ ansible_default_ipv4.address }}:4647"
    serf: "{{ ansible_default_ipv4.address }}:4648"
nomad_server_config:
  bootstrap_expect: 3
nomad_client_config:
  reserved:
    cpu: 500
    memory: 512
    disk: 1024
nomad_consul_config:
  token: D8D36BE5-8803-430C-8FBA-6F4FB032CB5B

```

```yaml
---
- hosts: nomad_servers
  vars:
    nomad_server_enabled: true
  roles:
    - role: nomad

- hosts: nomad_clients
  vars:
    nomad_user_managed: false
    nomad_user: root
    nomad_group: root
  roles:
    - role: nomad
```

License
-------

The MIT License (MIT)
Copyright (c) 2016 Brian Clark

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
