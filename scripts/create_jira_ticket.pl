#!/usr/bin/perl

# see https://jira.magnolia-cms.com/browse/SERVICES-345

use strict;
use warnings;

use JIRA::REST;

my $jira_url = 'https://jira.magnolia-cms.com';
my $jira_user = 'bandersen';
my $jira_pass = 'YOUR_PASSWD';
my $project = 'SERVICES';

my $jira = JIRA::REST->new($jira_url, $jira_user, $jira_pass);

# File a bug
my $issue = $jira->POST('/issue', undef, {
    fields => {
        project   => { key => $project },
        issuetype => { name => 'Task' },
        summary   => 'Test (Please Delete)',
        description => 'bradley sent this from a perl script.',
    },
});
