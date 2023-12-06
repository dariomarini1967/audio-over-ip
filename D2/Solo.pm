package Solo;
use parent GenericBus;

use strict;

sub new{
    my $class=shift;
    my $self=$class->SUPER::new(1003,"SOLO");
    return($self);
}

1;