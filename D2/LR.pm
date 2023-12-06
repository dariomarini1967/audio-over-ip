package LR;
use parent GenericBus;

use strict;

sub new{
    my $class=shift;
    my $self=$class->SUPER::new(1001,"LR");
    return($self);
}

1;