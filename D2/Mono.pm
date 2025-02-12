package Mono;
use parent GenericBus;

use strict;

sub new{
    my $class=shift;
    my $self=$class->SUPER::new(3,"Mono");
    return($self);
}

1;