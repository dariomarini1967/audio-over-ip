package GenericBus;
use parent PrintablePlug;

use strict;

sub new{
    my $class=shift;
    my $id=shift;
    my $name=shift;
    my $self=$class->SUPER::new(
        'console.bus',
        $id,
        $name,
        ElementAttributes->new->add("shape: oval")
    );
    $self->printMe;
    return($self);
}

1;