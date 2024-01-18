package MixBus;
use parent GenericBus;

use strict;

sub new{
    my $class=shift;
    my $id=shift;
    my $name=shift;
    if(defined($name)){
        $name=$name."\\n\\n(MixBus $id)";
    }else{
        $name="MixBus $id";
    }
    my $self=$class->SUPER::new(100+$id,$name);
    return($self);
}

1;