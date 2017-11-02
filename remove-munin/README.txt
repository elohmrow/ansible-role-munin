[1]
ansible-playbook remove-munin/playbooks/examples/remove_munin_node.yml -i remove-munin/hosts-munin-nodes --extra-vars
"ansible_sudo_pass=YOUR_REMOTE_PASSWD"

PLAY [munin-nodes] ****************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************
ok: [45.79.176.97]

TASK [stop munin-node processes] ******************************************************************************
changed: [45.79.176.97]

TASK [completely remove munin-node, configs, and dependencies] ************************************************
skipping: [45.79.176.97]

TASK [completely remove munin-node, configs, and dependencies] ************************************************
changed: [45.79.176.97]

PLAY RECAP ****************************************************************************************************
45.79.176.97               : ok=3    changed=2    unreachable=0    failed=0
