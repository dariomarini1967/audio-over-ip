package MixBus;
use parent GenericBus;

use strict;

sub new{
    my $class=shift;
    my $id=shift;
    my $name=shift;
    my $self=$class->SUPER::new($id,"$name\\n\\n(mixbus $id)");
    return($self);
}

1;