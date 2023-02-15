use strict;

my %alreadyCreated;

my %styles=(
	"xusb.BLOCK8.return"=>'#8ac926',
	"xusb.BLOCK8.send"=>'#bf0603',
	"phisicalOutput.BLOCK4.xlr"=>'#bf0603',
	"aux.jackin"=>'#8ac926',
	"aux.jackout"=>'#bf0603',
	"phisicalInput.BLOCK8.xlr"=>'#8ac926',
	"internalOutput.BLOCK8.out"=>'#a0a0a0'
);

package oneConnector;

sub new{
    my $class=shift;
    my $connectorName=shift;
    my $id=shift;
    if($alreadyCreated{$connectorName}{$id}){
        return $class;
    }
    $connectorName=~m/BLOCK([0-9])/;
    my $elementsPerBlock=$1;
    my $self={
        connectorName=>$connectorName,
        id=>$id,
        alreadyCreated=>0,
        elementsPerBlock=>$elementsPerBlock
    };
    $self=bless($self,$class);
    $self->printMe;
    $alreadyCreated{$self->{connectorName}}{$self->{id}}=1;
    return($self);
}

sub getBlockName{
    my $self=shift;
	my $id=$self->{id};
	my $elementsPerBlock=$self->{elementsPerBlock};
	my $lowest=1+$elementsPerBlock*int(($id-1)/$elementsPerBlock);
	my $highest=$lowest+$elementsPerBlock-1;
	return(sprintf("block%d-%d",$lowest,$highest));
}

sub printMe{
    my $self=shift;
    my $toPrint=$self->{connectorName};
    my $blockName=$self->getBlockName;
    $toPrint=~s/BLOCK[0-9]/$blockName/g;
    print "$toPrint".$self->{id}."\n";
}


package xlrIn;
our @ISA = qw(oneConnector);
sub new{
    my $class=shift;
    return $class->SUPER::new("phisicalInput.BLOCK8.xlr",shift); 
}

package xlrOut;
our @ISA = qw(oneConnector);
sub new{
    my $class=shift;
    return $class->SUPER::new("phisicalOutput.BLOCK4.xlr",shift); 
}

package usbReturn;
our @ISA = qw(oneConnector);
sub new{
    my $class=shift;
    return $class->SUPER::new("xusb.BLOCK8.return",shift); 
}

package usbSend;
our @ISA = qw(oneConnector);
sub new{
    my $class=shift;
    return $class->SUPER::new("xusb.BLOCK8.send",shift); 
}

package internalInput;
@ISA = qw(oneConnector);
sub new{
    my $class=shift;
    return $class->SUPER::new("internalInput.BLOCK8.ch",shift); 
}

package internalOutput;
our @ISA = qw(oneConnector);

sub new{
    my $class=shift;
    return $class->SUPER::new("internalOutput.BLOCK8.ch",shift); 
}



1;
