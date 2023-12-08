package Connector;
use parent PrintablePlug;

use ElementAttributes;

use strict;

sub new{
    my $class=shift;
    my $plugPath=shift;
    my $id=shift;
    my $name=shift;
    my $self=$class->SUPER::new(
        $plugPath,
        $id,
        $name,
        ElementAttributes->new->add("shape: circle")->add("style.fill: white"),
    );
    return($self);
}

1;