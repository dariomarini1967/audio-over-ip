#!/usr/bin/env perl

use D2Struct;

use strict;

my $a=D2Struct->new("inner_elements")
    ->addItem(D2Struct->new("a1"))
    ->addItem(D2Struct->new("b")
        ->addItem(D2Struct->new("c","d")));
print "$a";



my $a2=D2Struct->new("outer_elements");
$a2->addItem($a);
print "\n".$a2;



my $a1=D2Struct->new("element","10");
print "\n$a1";

# same as previous one
my $b1=D2Struct->new("element")->addItem("10");
print "\n$b1";
    