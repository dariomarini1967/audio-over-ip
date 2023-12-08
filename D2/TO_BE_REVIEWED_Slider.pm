package slider;
use parent GenericElement;

use strict;


sub getName{
    my $self=shift;
    my $toPrint=$self->{elementName};
    $toPrint.=$self->{id} if($self->{id}>0);
    return($toPrint);
}



package channelSlider;
our @ISA = qw(slider);
sub new{
    my $class=shift;
    my $channelId=shift;
    my $channelName=shift;
    my $self=$class->SUPER::new("console.ch",$channelId);
    return($self)if($self->{alreadyExists});
    $self->{attributes}->add("label:$channelId.$channelName");
    return($self); 
}

package busSlider;
our @ISA = qw(slider);
use Data::Dumper;

sub new{
    my $class=shift;
    my $busId=shift;
    my $busName=shift;
    my $self=$class->SUPER::new("console.bus",$busId);
    $self->{attributes}->add("label:$busId.$busName");
    return($self); 
}


package monoSlider;
our @ISA = qw(slider);
sub new{
    my $class=shift;
    my $self=$class->SUPER::new("console.M",0);
    return($self); 
}

package leftSlider;
our @ISA = qw(slider);
sub new{
    my $class=shift;
    my $self=$class->SUPER::new("console.STEREO.L",0);
    return($self); 
}

package rightSlider;
our @ISA = qw(slider);
sub new{
    my $class=shift;
    my $self=$class->SUPER::new("console.STEREO.R",0);
    return($self); 
}

# not a real slider!
package soloSlider;
our @ISA = qw(slider);
sub new{
    my $class=shift;
    my $self=$class->SUPER::new("console.SOLO",0);
    return($self); 
}

1;