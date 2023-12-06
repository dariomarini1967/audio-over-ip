package Mono;
use parent GenericBus;

use strict;

sub new{
    my $class=shift;
    my $self=$class->SUPER::new(1002,"M/C");
    return($self);
}

1;