package ElementsCollector;

use strict;

my $singleton;

sub get_instance{
    my $class=shift;
    if(not defined($singleton)){
        my %createdElements;
        $singleton={
            createdElements=>\%createdElements
        };
        bless($singleton, $class);
    }
    return($singleton);
}

sub exists{
    my $self=shift;
    my $key=shift;
    return(exists $self->{createdElements}->{$key});
}

sub addIfExists{
    my $self=shift;
    my $elementToAdd=shift; # type is GenericElement or descendants
    my $key=$elementToAdd->getFullId;
    if(not($self->exists($key))){
        $self->{createdElements}->{$key}=$elementToAdd;
        return($elementToAdd);
    }
    return($self->{createdElements}->{$key})
}

sub printAll{
    my $self=shift;
    my $hash_ref = $self->{createdElements};
    foreach(keys %$hash_ref){
        $self->{createdElements}->{$_}->printMe();
    }
}


1;
