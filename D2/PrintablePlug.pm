# PrintablePlug adds name, D2 attributes and methods to print itself

package PrintablePlug;
use parent GenericElement;

use D2Struct;

use Data::Dumper;
use Scalar::Util qw(weaken);


use strict;

use constant {
    ALWAYS_PRINT => 0,
    PRINT_IF_CONNECTED => 1,
};

my %colorMap = (
    "YE" => "#FCF300",
    "RD" => "#E72D2E",
    "GN" => "#35E72D",
    "BL" => "#0060FF",
    "MG" => "#FF00FF",
    "CY" => "#2DE0E7",
    "WH" => "#FFFFFF",
    "OFF" => "#5A5A5A"
);


sub new{
    my $class=shift;
    my $plugPath=shift;
    my $id=shift;
    my $self=$class->SUPER::new(
        $plugPath,
        $id
    );
    $self->setPrintMode(ALWAYS_PRINT) if(not defined($self->getPrintMode));
    my $initialD2=D2Struct->new($self->getFullId);
    $self->{attributes}=$initialD2;
    return($self);
}

sub addD2Attribute{
    my $self=shift;
    my $attribute=shift;
    $self->{attributes}->addItem($attribute);
    return($self);
}

sub setColor{
    my $self=shift;
    my $colorFromFile=shift;
    $colorFromFile =~ s/^\s+|\s+$//g;  # remove leading and trailing whitespace
    my $isInverted=$colorFromFile=~s/i$//;
    my $mappedColor=$colorMap{$colorFromFile};
    if(not defined($mappedColor)){
        $isInverted=0;
        $mappedColor="#F1F7AD";
    }
    if($isInverted ||$colorFromFile eq "OFF"){
        $self->addD2Attribute(D2Struct->new("style.font-color","'#000000'"));
        $self->addD2Attribute(D2Struct->new("style.fill","'".$mappedColor."'"));
    }else{
        $self->addD2Attribute(D2Struct->new("style.fill","'#000000'"));
        $self->addD2Attribute(D2Struct->new("style.font-color","'".$mappedColor."'"));
    }
    return($self);
}
 
sub setElementInput{
    my $self=shift;
    my $whichInput=shift;
    $self->{connectedInputElement}=$whichInput;
    return($self);
}

sub setElementOutput{
    my $self=shift;
    my $whichOutput=shift;
    push(@{$self->{connectedOutputElements}},$whichOutput);
    if(ref($whichOutput) ne "InternalPlug"){
        $self->printConnectionTo($whichOutput);
    }
    return($self);
}

sub printMe{
    my $self=shift;
    if($self->getPrintMode==ALWAYS_PRINT || scalar @{$self->{connectedOutputElements}} >0 || defined $self->{connectedInputElement}){ 
        print($self->getPrintable."\n");
        return(1);    
    }
    return(0);
}

sub getPrintable{
    my $self=shift;
    my $toPrint=$self->{attributes}->toString;
    return($toPrint);
}

sub getName{
    my $self=shift;
    return($self->{name});
}

sub setName{
    my $self=shift;
    my $name=shift;
    $self->{name}=$name;
    $self->addD2Attribute(D2Struct->new("label",$name));
    return($self);
}

sub setPrintMode{
    my $self=shift;
    $self->{printMode}=shift;
}

sub getPrintMode{
    my $self=shift;
    return($self->{printMode});
}




1;