#! /usr/bin/perl

use plug;
use slider;

use strict;

use constant{
    MAX_BUS=>1,
	MAX_XLR_OUTPUT=>8  # X32 rack has 8 output XLR...
};

# line describing internal input: /config/routing/IN AN1-8 AN9-16 CARD17-24 CARD25-32 AUX1-4
# line describing USB send:       /config/routing/CARD AN1-8 AN9-16 OUT1-8 OUT9-16
# line describing XLR output:     /config/routing/OUT OUT1-4 OUT5-8 OUT9-12 OUT13-16

# IN
my %inputObjectMap=(
	"AN"=>"xlrIn",
	"CARD"=>"usbReturn",
);

# CARD & OUT
my %outputObjectMap=(
	"AN"=>"xlrIn",
	"CARD"=>"usbSend",
	"OUT"=>"internalOutput"
);
 

sub printStructure{
  open(ELEMENTS,"<","x32_static.d2");
  print <ELEMENTS>;
  close(ELEMENTS);
}

sub groupToSingle{
	my $whichQuartet=shift;
	$whichQuartet=~m/^([A-Z]+)([0-9]+)-([0-9]+)$/;
	my $cardType=$1;
	my $firstCh=$2;
	my $lastCh=$3;
	my $i=$firstCh;
	my @tmp;
	while($i<=$lastCh){
		push(@tmp,$inputObjectMap{$cardType}->new($i++));
	}
	return(@tmp);
}



my $scnFile=shift;
die "Usage: $0 <.scn file>" if($scnFile eq "");

printStructure;

my @mustPrintSliderConn;
open(SCN_FILE,"<",$scnFile) or die "could not open $scnFile:$!";
while(<SCN_FILE>,){
    my $oneLine=$_;
    chomp($oneLine);
    $oneLine=~s/\s+(?=(?:(?:[^"]*"){2})*[^"]*"[^"]*$)/_/g;
    my($paramsString,@values)=split(/ +/,$oneLine);
    my @params=split(/\//,$paramsString);
    #my @values=split(" ",$valuesString);
    if($params[1] eq "config"){
		# general configuration
    	if($params[2] eq "mono"){
        	print "direction:left\nconsole.STEREO->console.M: mono depends on LR\ndirection:down\n" if ($values[1] eq "ON"); # i.e. /config/mono LR+M ON, got after flagging "M/C depends on Main LR"
		}elsif($params[2] eq "routing"){
			if($params[3] eq "IN"){
                # internal input
				# e.g. /config/routing/IN AN1-8 AN9-16 AN17-24 CARD25-32 AUX1-4
				# last value (AUX1-4) will not be considered, not clear
				my $i=1;
				foreach(groupToSingle($values[0])){
					$_->connect(internalInput->new($i++));
				}
				foreach(groupToSingle($values[1])){
                    $_->connect(internalInput->new($i++));
				}
				foreach(groupToSingle($values[2])){
                    $_->connect(internalInput->new($i++));
				}
				foreach(groupToSingle($values[3])){
                    $_->connect(internalInput->new($i++));
				}
			}elsif($params[3] eq "OUT"){

			}elsif($params[3] eq "CARD"){

			}
		}
    }elsif($params[1] eq "ch"){
        # channel configuration
        my $id=sprintf("%d",$params[2]);
        if($params[3] eq "config"){  # e.g. /ch/03/config "" 1 YE 3
            $values[0]=~s/"//g;
            if($values[0] ne ''){
              channelSlider->new($id,$values[0]);
              if($values[3]==39){
                print "usbkey.playL->console.ch$id\n";
              }elsif($values[3]==40){ 
                print "usbkey.playR->console.ch$id\n";
              }elsif($values[3]<=32){
				internalInput->new($values[3])->connect(channelSlider->new($id));
              }
              $mustPrintSliderConn[$id]=1;
            }
        }elsif($params[3] eq "mix" && $mustPrintSliderConn[$id]){
            if($values[0] eq "ON"){
                if(scalar(@params)==5){
                    # bus setting for this channel
                    my $busId=sprintf("%d",$params[4]);
                    channelSlider->new($id)->connect(busSlider->new($busId)) if ($busId<=MAX_BUS);
                }else{
                    # L,R,M setting
                    channelSlider->new($id)->connect(leftSlider->new) if ($values[2] eq "ON");
                    channelSlider->new($id)->connect(monoSlider->new) if ($values[4] eq "ON"); 
                }
            }
        }
    }elsif($params[1] eq "outputs"){
        # output board configuration
        if($params[2] eq "main"){
            if(scalar(@params)==4){
                my $id=sprintf("%d",$params[3]);
				my $whichOut=internalOutput->new($id);
                $whichOut->printMe;
                print "console.STEREO.L -> ".$whichOut->getName."\n" if($values[0]==1);
                print "console.STEREO.R -> ".$whichOut->getName."\n" if($values[0]==2);
                print "console.M -> ".$whichOut->getName."\n" if($values[0]==3);
                if($values[0]>3){
                    my $busId=$values[0]-3;
                    busSlider->new($busId)->connect($whichOut) if($busId<=MAX_BUS);
                }
            }
        }
    }
}


