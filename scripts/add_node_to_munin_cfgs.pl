#!/usr/bin/env perl

# @todo check if this node already exists before adding it

use strict;
use warnings;

# set to '1' to get extra info ...
our $DEBUG = 0;

=comment

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

=cut

# $munin_node and $munin_master should be given as ip addresses:
my ($munin_node, $munin_master) = @ARGV;

if (not (defined $munin_node and $munin_master)) {
    usage();
}

# this script assumes a certain relative location for
# the munin configuration files ... a possible improvement 
# might be to simply also pass those as params and / or 
# make adding a node a RESTful service ...
my $munin_master_cfg = 'munin-master/files/munin.conf';
my $munin_node_cfg   = 'munin-node/files/munin-node.conf';

my %args = (
    munin_node       => $munin_node,
    munin_master     => $munin_master,
    munin_node_cfg   => $munin_node_cfg,
    munin_master_cfg => $munin_master_cfg,
);

# do it!
add_munin_node_to_master(\%args);

# yes, there's duplication here ... because:
# actually editing the config files is done in a sub for future
# extendibility ... if this becomes a service, we can still call the
# sub the same way:
sub add_munin_node_to_master {
    my $args = shift;
    
    $munin_node     //= $args->{ 'munin_node' };
    $munin_master   //= $args->{ 'munin_master' };
    $munin_node_cfg   = $args->{ 'munin_node_cfg' };
    $munin_master_cfg = $args->{ 'munin_master_cfg' };

    # for testing:
    # could also do something with logger (/var/log/messages) 
    print STDERR "munin node: [" . $munin_node . "]\n" if $DEBUG;
    print STDERR "munin master: [" . $munin_master . "]\n" if $DEBUG;
    print STDERR "munin node cfg: [" . $munin_node_cfg . "]\n" if $DEBUG;
    print STDERR "munin master cfg: [" . $munin_master_cfg . "]\n" if $DEBUG;

    my $string_to_add_to_munin_master =<<"STATMM";

[$munin_node]
    address $munin_node
    use_node_name yes

STATMM
    print STDERR "adding this to munin master conf:\n" 
        . $string_to_add_to_munin_master . "\n" if $DEBUG;

    my $allow = $munin_master;
    $allow =~ s/\./\\\./g;
    my $string_to_add_to_munin_node =<<"STATMN";

allow ^$allow\$

STATMN
    print STDERR "adding this to munin node conf:\n" 
        . $string_to_add_to_munin_node . "\n" if $DEBUG;

    # now, we could get really cute about where to add these lines,
    # but, they can actually just be appended to the ends of the files:
    open(my $fh, '>>', $munin_master_cfg) or die "Could not open file '$munin_master_cfg': [$!]\n";
    	print $fh $string_to_add_to_munin_master;
    close $fh;
    
    open(my $fh, '>>', $munin_node_cfg) or die "Could not open file '$munin_node_cfg': [$!]\n";
    	print $fh $string_to_add_to_munin_node;
    close $fh;
    # could collapse those two blocks into a foreach ...
}

sub usage {
	my $usage = <<"USAGE";

========================================================================
You need to tell me:
	- the ip address of the munin node you wish to add
	- the ip address of the munin master you wish to add it to
Something like this:
	$0 45.79.176.97 176.58.102.50 
========================================================================

USAGE
 
	die $usage;    
}
