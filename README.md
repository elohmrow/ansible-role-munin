# munin-ibilly

Ansible Roles for installing munin monitors and nodes.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See Installing for notes on how to deploy the project on a live system.  Look in the hosts file on master for the url to a live demo.  

You can check out any individual node by making a URL like so:

http://$MUNIN_MASTER_IP/munin/$MUNIN_NODE_NAME/$MUNIN_NODE_NAME/$PLUGIN_NAME.html

For example: http://176.58.102.50/munin/MuninMaster/MuninMaster/threads.html
For example: http://176.58.102.50/munin/MuninNode1/MuninNode1/load.html

To figure out how to properly specify plugins in alert stanzas, on your master, do something like:

```
sudo munin-run $PLUGIN_NAME
```

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

* kdw for the idea
* http://do.co/2hfxPwm for the original, basic guidance
