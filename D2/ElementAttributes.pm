package ElementAttributes;

use strict;

sub new{
    my $class=shift;
    my @attrArray=();
    my $self={
        attrArray=>\@attrArray
    };
    return(bless($self,$class));
}

sub add{
    my $self=shift;
    my $toAdd=shift;
    push(@{$self->{attrArray}},$toAdd);
    return($self);
}

sub get{
    my $self=shift;
    my $tmp;
    return "" if(scalar(@{$self->{attrArray}})==0);
    $tmp="{\n";
    foreach(@{$self->{attrArray}}){
        $tmp.=" $_\n";
    }
    $tmp.="}\n";
    return($tmp);
}


1;