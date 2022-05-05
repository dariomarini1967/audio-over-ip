#! /usr/bin/perl

use strict;

if(!open(AVAHI,"<","/etc/avahi/avahi-daemon.conf")){
	exit(1);
}
my @a=<AVAHI>;
close(AVAHI);
my @b=grep(/^host-name/,@a);
if($b[0]=~m/=.*(palco|regia).*$/){
	print $1;
}else{
	exit(2);
}


