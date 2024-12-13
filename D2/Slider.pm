package Slider;
use parent PrintablePlug;

use D2Struct;

use strict;

sub new{
    my $class=shift;
    my $id=shift;
    my $name=shift;
    print "# trying to build slider $id\n";

    my $self=$class->SUPER::new(
        'console.ch',
        $id,
        
    );
    return($self) if($self->{previouslyCreated});
    print "# first time for slider $id\n";
    if(defined($name)){
        $self->setName("ch$id\\n\\n$name");    
    }else{
        $self->setName("ch__$id");
    }
    $self->addD2Attribute(D2Struct->new("shape","oval"));
    return($self);
}

sub setName{
    my $self=shift;
    my $name=shift;
    print "#setName: $name\n";
    $self->SUPER::setName($name);
    
    return($self);
}

1;