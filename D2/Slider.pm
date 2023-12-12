package Slider;
use parent PrintablePlug;

use D2Attributes;

use strict;

sub new{
    my $class=shift;
    my $id=shift;
    my $name=shift;
    my $self=$class->SUPER::new(
        'console.ch',
        $id,
        "ch$id\\n\\n$name",
        D2Attributes->new("shape","oval")
    );
    $self->printMe;
    return($self);
}

1;