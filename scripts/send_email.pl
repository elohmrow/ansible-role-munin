#!/usr/bin/env perl

use strict;
use warnings;

use Email::Sender::Simple qw(sendmail);
use Email::Simple;
use Email::Simple::Creator;
 
my $email = Email::Simple->create(
  header => [
    To      => '"Mr. On Call Dude" <bradley.andersen@magnolia-cms.com>',
    From    => '"Bradley Andersen" <bradley.andersen@magnolia-cms.com>',
    Subject => "somethin bad wrong happened!",
  ],
  body => "I sent this from a perl script.  I hope you like it.\n",
);
 
sendmail($email);
