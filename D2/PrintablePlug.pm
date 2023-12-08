package PrintablePlug;
use parent GenericElement;

use strict;

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
    my $name=shift;
    my $elementAttributes=shift;
    my $self=$class->SUPER::new(
        $plugPath,
        $id,
        $name,
        $elementAttributes
    );
    return($self);
}

sub setColor{
    my $self=shift;
    my $colorFromFile=shift;
    $colorFromFile =~ s/^\s+|\s+$//g;  # remove leading and trailing whitespace
    my $isInverted=$colorFromFile=~s/i$//;
    my $mappedColor=$colorMap{$colorFromFile};
    my @additionalAttributes=();
    if(not defined($mappedColor)){
        $isInverted=0;
        $mappedColor="#F1F7AD";
    }
    if($isInverted ||$colorFromFile eq "OFF"){
        push(@additionalAttributes,"style.font-color: '#000000'");
        push(@additionalAttributes,"style.fill: '".$mappedColor."'");

    }else{
        push(@additionalAttributes,"style.fill: '#000000'");
        push(@additionalAttributes,"style.font-color: '".$mappedColor."'");
    }
    if($self->{alreadyPrinted}==1){
        # print just new attributes in case the element has already been printed
        print join("\n",map($self->{elementPath}.$self->{id}.".".$_,@additionalAttributes))."\n";
    }
    # add the new attributes
    map($self->{attributes}->add($_),@additionalAttributes);
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
#package xlrIn;
#our @ISA = qw(plug);


1;