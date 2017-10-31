#!/usr/bin/env perl

use strict;
use warnings;

use Email::Sender::Simple qw(sendmail);
use Email::Simple;
use Email::Simple::Creator;

my ($email_to, $host, $service_name) = @ARGV;

if (not (defined $email_to and $host and $service_name)) {
    usage();
}

my $email_from = "bradley.andersen\@magnolia-cms.com";
my $email_body = "Host: [$host] Service: [$service_name] is down.\n";
 
my $email = Email::Simple->create(
  header => [
    To      => $email_to,
    From    => "'**** Munin Alerts ****' <$email_from>",
    Subject => $service_name,
  ],
  body => $email_body,
);
 
sendmail($email);

sub usage {
	my $usage = <<"USAGE";

================================================================================
You need to tell me:
	- the email address of the alert contact 
	- the hostname or ip address of the machine having problems 
	- the name of the service having problems 
Something like this:
	$0 bradley.andersen\@magnolia-cms.com 192.168.0.4 disk_usage 
================================================================================

USAGE
 
	die $usage;    
}
