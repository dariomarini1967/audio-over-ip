package SoloL;
use parent GenericBus;

use strict;

sub new{
    my $class=shift;
    my $self=$class->SUPER::new(4,"SoloL");
    return($self);
}

1;