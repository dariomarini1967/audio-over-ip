package GenericElement;

use ElementAttributes;

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
    my $name=shift;
    my $e=shift or ElementAttributes->new;    
    die "could not create an element with id <= 0" if($id<=0);
    # Check if the element has already been created with the given name and id
    return $createdElements{$elementPath.$id} if (exists $createdElements{$elementPath.$id});

    # Create a new instance of the class with the provided attributes
    # and store it in the createdElements hash
    my $self = {
        elementPath => $elementPath,
        id => $id,
        attributes => $e,
        connectedOutputElements => [],  # array containing destination elements current element connects to
        connectedInputElement => undef,
        name =>"NA",
        alreadyPrinted => 0  # 1 means that printMe method has already been called once
    };
    $self = bless($self, $class);
    $createdElements{$self->{elementPath}.$self->{id}} = $self;
    $self->setName($name) if($name);
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

sub getName{
    my $self=shift;
    return($self->{name});
}

sub setName{
    my $self=shift;
    my $name=shift;
    $self->{name}=$name;
    $self->{attributes}->add("label: $name");
    return($self);
}

sub getPrintable{
    my $self=shift;
    my $toPrint=$self->{elementPath}.$self->{id};
    my $attributes=$self->{attributes}->get;
    $toPrint.=":".$attributes if($attributes);
    return($toPrint);
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