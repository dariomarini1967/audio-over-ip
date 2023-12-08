package InternalPlug;
use parent GenericElement;

use strict;

sub new{
    my $class=shift;
    my $plugPath=shift;
    my $id=shift;
    my $name=shift;
    my $self=$class->SUPER::new($plugPath,$id);
    $self->{completed}=0;
    return($self);
}

sub setElementInput{
    my $self=shift;
    my $whichInput=shift;
    if(scalar(@{$self->{connectedOutputElements}})>0){
        $self->{completed}=1;
        $self->{connectedOutputElements}->[0]->setElementInput($whichInput);
        $whichInput->setElementOutput($self->{connectedOutputElements}->[0]);
        $self->{connectedOutputElements}->[0]->setElementInput($whichInput);
    }else{
        $self->{connectedInputElement}=$whichInput;
    }
    return($self);
}

sub setElementOutput{
    my $self=shift;
    my $whichOutput=shift;
    if($self->{connectedInputElement}){
        $self->{completed}=1;
        $self->{connectedInputElement}->setElementOutput($whichOutput);
        $whichOutput->setElementInput($self->{connectedInputElement});
    }else{
        push(@{$self->{connectedOutputElements}},$whichOutput);
    }
    return($self);
}

sub printMe{
    # we actually don't print InternalPlugs
    my $self=shift;
    return 1;
}

#package xlrIn;
#our @ISA = qw(plug);


1;