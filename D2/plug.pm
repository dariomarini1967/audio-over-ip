package plug;
use parent genericElement;

use strict;

my %plugColors=(
	"xusb.BLOCK8.return"=>'#8ac926',
	"xusb.BLOCK8.send"=>'#bf0603',
	"phisicalOutput.BLOCK4.xlr"=>'#bf0603',
	"aux.jackIn"=>'#8ac926',
	"aux.jackOut"=>'#bf0603',
	"phisicalInput.BLOCK8.xlr"=>'#8ac926',
    "internalInput.BLOCK8.ch"=>'#a0a0a0',
	"internalOutput.BLOCK8.ch"=>'#a0a0a0'
);


sub new{
    my $class=shift;
    my $plugName=shift;
    my $id=shift;
    my $self=$class->SUPER::new($plugName,$id);
    return($self)if($self->{alreadyExists});
    $plugName=~m/BLOCK([0-9])/;
    my $elementsPerBlock=$1;
    $self->{elementsPerBlock}=$elementsPerBlock;
    $self->{attributes}->add("shape: circle");
    $self->{attributes}->add("style.fill: '".$plugColors{$self->{elementName}}."'");
    return($self);
}

# used by getPrintable
sub getBlockName{
    my $self=shift;
	my $id=$self->{id};
	my $elementsPerBlock=$self->{elementsPerBlock};
	my $lowest=1+$elementsPerBlock*int(($id-1)/$elementsPerBlock);
	my $highest=$lowest+$elementsPerBlock-1;
	return(sprintf("block%d-%d",$lowest,$highest));
}

sub getName{
    my $self=shift;
    #print "DEBUG ".ref($self)."\n";
    my $toPrint=$self->{elementName};
    my $blockName=$self->getBlockName;
    $toPrint=~s/BLOCK[0-9]/$blockName/g;
    return("$toPrint".$self->{id});
}


package xlrIn;
our @ISA = qw(plug);
sub new{
    my $class=shift;
    return $class->SUPER::new("phisicalInput.BLOCK8.xlr",shift); 
}

package xlrOut;
our @ISA = qw(plug);
sub new{
    my $class=shift;
    return $class->SUPER::new("phisicalOutput.BLOCK4.xlr",shift); 
}

package usbReturn;
our @ISA = qw(plug);
sub new{
    my $class=shift;
    return $class->SUPER::new("xusb.BLOCK8.return",shift); 
}

package usbSend;
our @ISA = qw(plug);
sub new{
    my $class=shift;
    return $class->SUPER::new("xusb.BLOCK8.send",shift); 
}

package internalInput;
our @ISA = qw(plug);
sub new{
    my $class=shift;
    return $class->SUPER::new("internalInput.BLOCK8.ch",shift); 
}

package internalOutput;
our @ISA = qw(plug);

sub new{
    my $class=shift;
    return $class->SUPER::new("internalOutput.BLOCK8.ch",shift); 
}

package auxIn;
our @ISA = qw(plug);

sub new{
    my $class=shift;
    return $class->SUPER::new("aux.jackIn",shift); 
}

package auxOut;
our @ISA = qw(plug);

sub new{
    my $class=shift;
    return $class->SUPER::new("aux.jackOut",shift); 
}

1;