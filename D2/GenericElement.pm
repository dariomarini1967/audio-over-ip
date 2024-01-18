package GenericElement;

use ElementsCollector;

use Data::Dumper;

use strict;




sub new{
    my $class=shift;
    my $elementPath=shift;
    my $id=shift;
    die "could not create an element with id <= 0" if($id<=0);
    my $self = {
        elementPath => $elementPath,
        id => $id,
        connectedOutputElements => [],  # array containing destination elements current element connects to
        connectedInputElement => undef,
        previouslyCreated => 0, # not used
    };
    $self = bless($self, $class);
    return(ElementsCollector->get_instance->addIfExists($self));
}


sub printMe {
    # actually does not print, only PrintablePlug will override this method and print
    my $self=shift;
    return 0;
}

sub getFullId{
    # fullId is elementPath+id, this is univoque
    my $self=shift;
    return($self->{elementPath}.$self->{id});
}

sub connect{
    my $self=shift;
    my $dest=shift;
    #print "connecting $self->{elementPath}$self->{id} to $dest->{elementPath}$dest->{id}\n(".ref($self)."---->".ref($dest).")\n";
    $self->setElementOutput($dest);
    $dest->setElementInput($self);
    return($self);
}

sub printConnectionTo{
    my $self=shift;
    my $dest=shift;
    #$self->printMe;
    #$dest->printMe;
    print $self->getFullId . " -> " . $dest->getFullId . "\n";
    return($self);
}



1;