#! /usr/bin/env perl

use Connector;
use InternalPlug;
use Slider;
use SoloL;
use SoloR;
use Mono;
use MainL;
use MainR;
use MixBus;

use ElementsCollector;

use Switch;
use Data::Dumper;

use strict;

use constant{
    MAX_BUS=>1,
	MAX_XLR_OUTPUT=>8  # X32 rack has 8 output XLR...
};


# following buses are always present!
my $mono=Mono->new;
my $mainL=MainL->new;
my $mainR=MainR->new;
my $soloL=SoloL->new;
my $soloR=SoloR->new;


# line describing Input screen (group by 8): /config/routing/IN AN1-8 AN9-16 CARD17-24 CARD25-32 AUX1-4
# line describing Card screen (group by 8) : /config/routing/CARD AN1-8 AN9-16 OUT1-8 OUT9-16
# line describing XLR screen (group by 4!) : /config/routing/OUT OUT1-4 OUT5-8 OUT9-12 OUT13-16 
# lines describing Out 1-16 screen (no group): /outputs/main/XX (XX=01-16)
# lines describing Aux Out screen (no group): /outputs/aux/XX (XX=01-06)

# Sources in Input screen
my %inputObjectMap=(
	"AN"=>"PHISICAL.xlrPanel.femaleXlr.in",
	"CARD"=>"PHISICAL.xusbCard.return.ch",
);

# Sources in Card screen
my %cardObjectMap=(
	"AN"=>"PHISICAL.xlrPanel.femaleXlr.in",
	"CARD"=>"PHISICAL.xusbCard.return.ch",   # what should be used for?
	"OUT"=>"internalOutput.ch",
    "AUX/CR"=>"PHISICAL.auxPanel.outTRS.plug",
    "AUX/TB"=>"PHISICAL.auxPanel.inTRS.plug"
);

# Sources in XLR screen
my %xlrObjectMap=%cardObjectMap;  # they are the same as Card screen

my %liveOrVirt=(
    "REC"=>"live",
    "PLAY"=>"virtual sound check"
);
 


my $scnFile=shift;
die "Usage: $0 <.scn file>" if($scnFile eq "");

open(DEBUG,">xair_to_d2.log") or die "could not open debug.log:$!";

my $playOrRec="REC"; # live use (REC) or virtual sound check (PLAY)
open(SCN_FILE,"<",$scnFile) or die "could not open $scnFile:$!";

# insert static elements; they are store in macroblocks.d2 
if(open(MACROBLOCKS_FILE,"<","macroblocks.d2")){
    print DEBUG "reading macroblocks.d2\n";
    while(<MACROBLOCKS_FILE>){
        print "$_";
    }
    close(MACROBLOCKS_FILE);
}

while(<SCN_FILE>,){
    my $oneLine=$_;
    chomp($oneLine);

    # /config/routing/ lines processing
    if($oneLine =~ m{^/config/routing (PLAY|REC)$}) {   # e.g. /config/routing PLAY
        $playOrRec = $1;
        print DEBUG "$oneLine ---> ".$liveOrVirt{$playOrRec}." mode selected\n";
    }elsif($oneLine =~ m{^/config/routing/}){ # e.g. /config/routing/IN AN1-8 AN9-16 CARD17-24 CARD25-32 AUX1-4
        my $restOfLine = $'; # e.g. IN AN1-8 AN9-16 CARD17-24 CARD25-32 AUX1-4
        my @sources = split(" ",$restOfLine);
        my $screenType=shift(@sources); # can be IN, CARD or OUT
        switch($screenType){
            case "IN" { 
                if($playOrRec eq "REC"){
                    print DEBUG "$oneLine ---> config made in Input screen\n";
                    my $internalPlugId=1;
                    # loop through 4 octets
                    for(my $i=0;$i<4;$i++){   # e.g. AN1-8 AN9-16 AN17-24 CARD25-32
                        $sources[$i] =~ /^(AN|CARD)(\d+)?(-(\d+))?$/ or die "$sources[$i] string not expected in line /config/routing/IN";
                        my $str = $1;   # e.g. AN
                        my $from = $2;  # e.g. 1
                        my $to = $4;    # e.g. 8
                        # loop through the octet
                        for(my $j=$from;$j<=$to;$j++){
                            Connector->new($inputObjectMap{$str},$j)->connect(InternalPlug->new("internalInput.ch",$internalPlugId++));
                        }
                        print DEBUG $sources[$i]." --> $str from $from to $to\n";
                    }
                }else{
                    print DEBUG "$oneLine ---> ignored as ".$liveOrVirt{$playOrRec}." mode is selected\n";
                }
            }
            case "CARD" { print DEBUG "$oneLine ---> config made in Card screen\n"; }
            case "OUT" { print DEBUG "$oneLine ---> config made in XLR screen\n"; }
            case "PLAY" {
                if($playOrRec eq "PLAY"){
                    print DEBUG "$oneLine ---> config made in Input screen\n";
                }else{
                    print DEBUG "$oneLine ---> ignored as ".$liveOrVirt{$playOrRec}." mode is selected\n";
                }
            }
            else { print DEBUG "$oneLine ---> ignored\n"; }            
        }
    }elsif($oneLine =~ m{^/ch/([0-9][0-9])/}){ # e.g. /ch/01/
        my $channel=$1;
        $oneLine=~s{^/ch/$channel/}{};
        if($oneLine=~m/^config /){ # e.g. /ch/01/config "Bolla" 50 YE 1
            $oneLine=~s/^config //;
            print DEBUG "$oneLine ---> configuration of input and name for channel $channel:";
            my ($channelName,$icon,$color,$internalInputId) = $oneLine =~ /(?:\d+|"[^"]*"|\S+)\s*/g;
            $channelName =~ s/"//g;
            print DEBUG "$channelName,$icon,$color,$internalInputId\n";
            if($internalInputId<=32 && $internalInputId>=1){
                my $tmpSlider=Slider->new($channel);
                $tmpSlider->setName($channelName)->setColor($color);
                print DEBUG Dumper($tmpSlider)."\n";
                InternalPlug->new("internalInput.ch",$internalInputId)->connect($tmpSlider);
            }
        }elsif($oneLine=~m/^mix /){ # e.g. /ch/01/mix OFF  -4.1 ON +0 OFF   -oo
            $oneLine=~s/^mix //;
            print DEBUG "$oneLine ---> configuration of slider output to LR & MONO for $channel\n";
            my ($dummy1,$dummy2,$onLR,$dummy3,$onMono)=split(" +",$oneLine);
            if($onLR eq "ON"){
                Slider->new($channel)->connect($mainL);
                Slider->new($channel)->connect($mainR);
            }
            if($onMono eq "ON"){
                Slider->new($channel)->connect($mono);
            }
        }
    }elsif($oneLine =~ m{^/outputs/main/([0-9][0-9]) }){ # e.g. /outputs/main/01 4 POST OFF
        my $channel=$1;
        $oneLine=~s{^/outputs/main/$channel }{};
        my ($sourceId,$prePost,$OnOFF)=split(/ /,$oneLine);
        print DEBUG "$oneLine ---> set input $channel of internal outputto $sourceId\n";
        switch($sourceId){
            case 1 {$mono->connect(InternalPlug->new("internalOutput.ch",$channel));}
            case 2 {$mainL->connect(InternalPlug->new("internalOutput.ch",$channel));}                
            case 3 {$mainR->connect(InternalPlug->new("internalOutput.ch",$channel));}
            case [4..19] {MixBus->new($sourceId-3)->connect(InternalPlug->new("internalOutput.ch",$channel));}
            case [20..51] {Slider->new($sourceId-19)->connect(InternalPlug->new("internalOutput.ch",$channel));}
        }
    }
}
ElementsCollector->get_instance->printAll;
close(SCN_FILE);


