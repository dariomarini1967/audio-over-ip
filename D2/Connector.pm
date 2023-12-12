package Connector;
use parent PrintablePlug;

use D2Attributes;

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
        D2Attributes->new($plugPath.$id)
            ->addItem(D2Attributes->new("shape","circle"))
            ->addItem(D2Attributes->new("style.fill","white")),
    );
    return($self);
}

1;