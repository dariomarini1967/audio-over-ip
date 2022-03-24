#! /usr/bin/bash

param=$1

if [ "$param" == "" ]
then
	echo Available sound cards
	cat /proc/asound/cards
	echo ""
	echo "Please invoke $0 with value inside [] to make soundcard available in jack" 
	exit
fi

card_line=$(grep "\["$param /proc/asound/cards)
if [ $? -ne 0 ]
then
	echo card $param does not exist
	exit
fi
card_number=$(echo $card_line | cut -d" " -f1)
echo "connecting to hw:$card_number [$param]"

# aggiunge come seconda scheda audio

nohup alsa_out -j second_out -d hw:$card_number 2>&1 >> second_out.log &
nohup alsa_in -j second_in -d hw:$card_number 2>&1 >> second_in.log &






