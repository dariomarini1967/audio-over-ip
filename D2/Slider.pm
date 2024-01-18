package Slider;
use parent PrintablePlug;

use D2Struct;

use strict;

sub new{
    my $class=shift;
    my $id=shift;
    my $name=shift;
    my $self=$class->SUPER::new(
        'console.ch',
        $id,
        
    );
    if(defined($name)){
        $self->setName("ch$id\\n\\n$name");    
    }else{
        $self->setName("ch$id");
    }
    $self->addD2Attribute(D2Struct->new("shape","oval"));
    return($self);
}

1;