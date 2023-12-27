package GenericElement;

use D2Attributes;

use Data::Dumper;

use strict;

# IDs
# <ch> Mixer channel <ch
# 1001 L
# 1002 R
# 1003 MONO
# 1004 SoloL
# 1005 SoloR
# 2000+<ch> MixBus<ch>
# 3000+<ch> AUX<ch>

use constant {
    NEVER_PRINT => 0,
    ALWAYS_PRINT => 1,
    PRINT_IF_CONNECTED => 2,
};

my %createdElements;

sub new {
    my $class=shift;
    my $elementPath=shift;
    my $id=shift;
    die "could not create an element with id <= 0" if($id<=0);
    # Check if the element has already been created with the given name and id
    if (exists $createdElements{$elementPath.$id}){
        my $self=$createdElements{$elementPath.$id};
        $self->{alreadyCreated}=1;  # useful inside derived classes, even if not used up to now
        return($self);
    }
    
    # Create a new instance of the class with the provided attributes
    # and store it in the createdElements hash
    my $self = {
        elementPath => $elementPath,
        id => $id,
        connectedOutputElements => [],  # array containing destination elements current element connects to
        connectedInputElement => undef,
        alreadyCreated => 0,
        alreadyPrinted => 0  # 1 means that printMe method has already been called once
    };
    $self = bless($self, $class);
    $createdElements{$self->{elementPath}.$self->{id}} = $self;
    return ($self);
}


sub printMe {
    # call always, print once per object
    my ($self) = @_;
    return 0 if ($self->{alreadyPrinted});
    print $self->getPrintable . "\n";
    $self->{alreadyPrinted} = 1;
    return 1;
}

sub getFullId{
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
    $self->printMe;
    $dest->printMe;
    print "$self->{elementPath}$self->{id} -> $dest->{elementPath}$dest->{id}\n";
    return($self);
}
 


1;