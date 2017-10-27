# munin-ibilly

Ansible Roles for installing munin monitors and nodes.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Debians or Red Hats

Debians tested: 9

Red Hats tested: 7

### Installing

Install munin-master

```
ansible-playbook munin-master/playbook.yml -i munin-master/hosts --extra-vars "ansible_sudo_pass=YOUR_REMOTE_PASSWD"
```

Install munin-node

```
ansible-playbook munin-node/playbook.yml -i munin-node/hosts --extra-vars "ansible_sudo_pass=YOUR_REMOTE_PASSWD"
```

## Authors

* **elohmrow** - (https://github.com/elohmrow)

## License

This free software; you can redistribute it and/or modify it under the terms of the "Artistic License". 

## Acknowledgments

* kdw
