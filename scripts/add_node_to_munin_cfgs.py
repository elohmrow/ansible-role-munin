# @todo check if this node already exists before adding it

from __future__ import print_function
import sys

'''
When we add a machine to be monitored, we must: 

[1] add a stanza like so into the munin master's munin.conf:

            [MuninNodeName]
                address 45.79.176.97
                use_node_name yes

where the ip address is the ip address of the munin node
that we are adding, and the [MuninNodeName] is free-form, but
probably best to be just a repeat of the ip address.

[2] add a line like so into the munin node's munin-node.conf:

            allow ^176\.58\.102\.50$

where that ip address is the ip address of the munin master 
for this munin node.  This regexp format is fixed, unless you
want to add more Perl deps.

'''

if (len(sys.argv) < 3):  
    usage = """\n========================================================================
    You need to tell me:
            - the ip address of the munin node you wish to add
            - the ip address of the munin master you wish to add it to
    Something like this:
            {0} 45.79.176.97 176.58.102.50
========================================================================\n"""

    print(usage.format(sys.argv[0]))
    sys.exit(0)

# $munin_node and $munin_master should be given as ip addresses:
munin_node   = sys.argv[1]
munin_master = sys.argv[2]

# this script assumes a certain relative location for
# the munin configuration files ... a possible improvement 
# might be to simply also pass those as params and / or 
# make adding a node a RESTful service ...
munin_master_cfg = 'munin-master/files/munin.conf';
munin_node_cfg   = 'munin-node/files/munin-node.conf';

# yes, there's duplication here ... because:
# actually editing the config files is done in a sub for future
# extendibility ... if this becomes a service, we can still call the
# sub the same way:
def add_munin_node_to_master(**args):
    munin_node       = args['munin_node']
    munin_master     = args['munin_master']
    munin_node_cfg   = args['munin_node_cfg']
    munin_master_cfg = args['munin_master_cfg']

    # for testing:
    # could also do something with logger (/var/log/messages) 
    if __debug__:
        print("munin node: [{0}]".format(munin_node))
        print("munin master: [{0}]".format(munin_master))
        print("munin node cfg: [{0}]".format(munin_node_cfg))
        print("munin master cfg: [{0}]".format(munin_master_cfg))

    string_to_add_to_munin_master = """\n
[{0}]
    address {0}
    use_node_name yes
\n"""

    # now, we could get really cute about where to add these lines,
    # but, they can actually just be appended to the ends of the files:
    with open(munin_master_cfg, 'a') as cfg:
	cfg.write(string_to_add_to_munin_master.format(munin_node))

    string_to_add_to_munin_node = """\n
{0}
\n"""

    allow = munin_master.replace(".", "\.")
    allow = "allow ^" + allow + "$"
    with open(munin_node_cfg, 'a') as cfg:
	cfg.write(string_to_add_to_munin_node.format(allow))

    if __debug__:
        print("adding this to munin master conf:\n: {0}".format(string_to_add_to_munin_master.format(munin_node)))
        print("adding this to munin node conf:\n: {0}".format(string_to_add_to_munin_node.format(allow)))

args = {
       'munin_node': munin_node,
       'munin_master': munin_master,
       'munin_node_cfg': munin_node_cfg,
       'munin_master_cfg': munin_master_cfg
        }

# do it!
add_munin_node_to_master(**args);
