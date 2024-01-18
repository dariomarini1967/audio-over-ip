package SoloR;
use parent GenericBus;

use strict;

sub new{
    my $class=shift;
    my $self=$class->SUPER::new(5,"SoloR");
    return($self);
}

1;