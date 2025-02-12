package MainL;
use parent GenericBus;

use strict;

sub new{
    my $class=shift;
    my $self=$class->SUPER::new(1,"MainL");
    return($self);
}

1;