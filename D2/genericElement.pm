package genericElement;

use ElementAttributes;

use Data::Dumper;

use strict;

my %alreadyCreated;

sub new{
    my $class=shift;
    my $elementName=shift;
    my $id=shift;
    if($alreadyCreated{$elementName}{$id}){
        $alreadyCreated{$elementName}{$id}->{alreadyExists}=1;
        return $alreadyCreated{$elementName}{$id};
    }
    my $e=ElementAttributes->new;
    my $self={
        elementName=>$elementName,
        id=>$id,
        alreadyPrinted=>0,
        attributes=>$e,
    };
    $self=bless($self,$class);
    $alreadyCreated{$self->{elementName}}{$self->{id}}=$self;
    return($self);
}

sub printMe{
    # call always, print once per object
    my $self=shift;
    return(0) if ($self->{alreadyPrinted});
    print $self->getPrintable."\n";
    $self->{alreadyPrinted}=1;
    return(1);
}

# must be overridden
sub getName{
    my $self=shift;
    return("dummy");
}

# should not be overridden
sub getPrintable{
    my $self=shift;
    my $toPrint=$self->getName;
    $toPrint.=$self->{attributes}->get;
    return($toPrint);
}

sub connect{
    my $self=shift;
    my $dest=shift;
    $self->printMe;
    $dest->printMe;
    print $self->getName." -> ".$dest->getName."\n";
}
1;