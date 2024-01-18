package GenericBus;
use parent PrintablePlug;

use strict;

# IDs for console.ch (Slider classes)
# <ch> Mixer channel<ch>

# IDs for console.bus (GenericBus descendant classes)
# 1 MainL
# 2 MainR
# 3 MONO
# 4 SoloL
# 5 SoloR
# 100+<ch> MixBus<ch>
# 200+<ch> AUX<ch>

sub new{
    my $class=shift;
    my $id=shift;
    my $name=shift;
    my $printMode=shift;
    my $self=$class->SUPER::new(
        'console.bus',
        $id,
        $printMode
    );
    $self->setName($name);
    $self->addD2Attribute(D2Struct->new("shape","square"));
    return($self);
}

1;