#!/usr/bin/env perl

use D2Attributes;

use strict;

my $a=D2Attributes->new("ciao")
    ->addItem(D2Attributes->new("a","A"))
    ->addItem(D2Attributes->new("b")
        ->addItem(D2Attributes->new("c","d")));
print "$a";

my $a1=D2Attributes->new("ciao","10");
print "\n$a1";

my $a2=D2Attributes->new("ciao");
print "\n$a2";

    