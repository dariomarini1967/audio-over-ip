package D2Struct;

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
    # new("name","value") is a shortcut for new("name")->setValue("value") 
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
    my $toAdd=shift;  # type can be string or D2Struct
    if(ref($toAdd) ne "D2Struct"){
        $self->setValue($toAdd);
    }else{
        die("value is present") if (defined($self->{value}));
        push(@{$self->{attrArray}},$toAdd);
    }
    return($self);
}

use overload
    '""' => \&toString;

sub toString{
    my $self=shift;
    my $tmp;
    $tmp=$self->{name};
    if(defined($self->{value})){
        $tmp.=": ".$self->{value};
    }else{
        my $composite;
        foreach(@{$self->{attrArray}}){
            my $tmp1=$_->toString."\n";
            # preceed each line in $tmp1 by one tab, do not consider last \n
            $tmp1=~s/\n(?!$)/\n\t/g;
            $composite.="\t$tmp1";
        }
        $tmp.=": {\n$composite}" if(defined($composite));
    }
    return($tmp);
}



1;