package D2Attributes;

use Data::Dumper;

use strict;

sub new{
    my $class=shift;
    my $name=shift;
    my $value=shift; # can be undef
    my @attrArray=();
    my $self={
        name=>$name,
        value=>undef,
        attrArray=>\@attrArray
    };
    bless($self,$class);
    $self->setValue($value) if(defined($value));
    return($self);
}

sub setValue{
    my $self=shift;
    my $value=shift;
    die("elements are present") if(scalar(@{$self->{attrArray}})>0);
    $self->{value}=$value;
    return($self);
}

sub addItem{
    my $self=shift;
    my $toAdd=shift;  # type is D2Attributes
    die("only D2Attributes are allowed") if(ref($toAdd) ne "D2Attributes");
    die("value is present") if (defined($self->{value}));
    push(@{$self->{attrArray}},$toAdd);
    return($self);
}

use overload
    '""' => \&printAttr;

sub printAttr{
    my $self=shift;
    my $tmp;
    $tmp=$self->{name};
    if(defined($self->{value})){
        $tmp.=": ".$self->{value};
    }else{
        my $composite;
        foreach(@{$self->{attrArray}}){
            my $tmp1=$_->printAttr."\n";
            # preceed each line in $tmp1 by one tab, do not consider last \n
            $tmp1=~s/\n(?!$)/\n\t/g;
            $composite.="\t$tmp1";
        }
        $tmp.=": {\n$composite}" if(defined($composite));
    }
    return($tmp);
}

1;