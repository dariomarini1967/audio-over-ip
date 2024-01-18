package Connector;
use parent PrintablePlug;

use D2Struct;

use strict;

sub new{
    my $class=shift;
    my $connectorPath=shift;
    my $id=shift;
    my $name=shift;
    my $self=$class->SUPER::new(
        $connectorPath,
        $id
    );
    $self->setName($name) if(defined($name));
    $self->addD2Attribute(D2Struct->new("shape","circle"));
    $self->addD2Attribute(D2Struct->new("style.fill","white"));
    return($self);
}

1;