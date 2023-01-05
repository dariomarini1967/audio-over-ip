#! /usr/bin/perl

use File::Basename;

use strict;

open(AVAHI,"<","/etc/avahi/avahi-daemon.conf") or die;
my @a=<AVAHI>;chomp(@a);
close(AVAHI);
my @b=grep(/^host-name/,@a);
die("cannot find host-name parameter in /etc/avahi/avahi-daemon.conf")unless(scalar(@b)==1);
my $this_host=$b[0];
$this_host=~s/^.*=//g;
$this_host.=".local";


open(ADDRESSES,"<",dirname($0)."/ADDRESSES.cfg") or die;
my @addresses=<ADDRESSES>;chomp(@addresses);
close(ADDRESSES);
my @c=grep(/$this_host/,@addresses);
die("cannot find this host ($this_host) in ADDRESSES.cfg")unless(scalar(@c)==1);
$c[0]=~m/^host_(.+)=/;
print $1;


