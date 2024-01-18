package MainR;
use parent GenericBus;

use strict;

sub new{
    my $class=shift;
    my $self=$class->SUPER::new(2,"MainR");
    return($self);
}

1;