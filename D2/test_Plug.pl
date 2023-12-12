#! /usr/bin/env perl

use Slider;
use Connector;
use InternalPlug;

use Data::Dumper;

use strict;
use warnings;

# Create Connector and InternalPlug objects
my $plug1 = Connector->new("rear_panel.xlr",1);
my $plug2 = Connector->new("rear_panel.xlr",2);
my $plug3 = Connector->new("rear_panel.xlr",3);
my $plug4 = Connector->new("rear_panel.xlr",4);

my $plug5 = Connector->new("rear_panel.xlr",5);
my $plug6 = Connector->new("rear_panel.xlr",6);
my $plug7 = Connector->new("rear_panel.xlr",7);
my $plug8 = Connector->new("rear_panel.xlr",8);

my $internalPlug1 = InternalPlug->new("internal_patch",1);
my $internalPlug2 = InternalPlug->new("internal_patch",2);
my $internalPlug3 = InternalPlug->new("internal_patch",3);
my $internalPlug4 = InternalPlug->new("internal_patch",4);

print "1)\n";
$plug1->connect($internalPlug2);

print "2)\n";
$internalPlug2->connect($internalPlug1);

print "3)\n";
$internalPlug1->connect($plug2);
print $internalPlug2->{completed}."\n";

print "4)\n";
my $slider1=Slider->new(1,"chitarra");

print "5)\n";
my $slider2=Slider->new(2,"voce");
my $slider3=Slider->new(3,"tastiera");
my $slider4=Slider->new(4,"batteria");
