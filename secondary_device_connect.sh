#! /usr/bin/bash

param=$1

if [ "$param" == "" ]
then
	echo Available sound cards
	cat /proc/asound/cards
	exit
fi

card_line=$(grep "\["$param /proc/asound/cards)
if [ $? -ne 0 ]
then
	echo card $param does not exist
	exit
fi
card_number=$(echo $card_line | cut -d" " -f1)
echo connecting to hw:$card_number

# aggiunge come seconda scheda audio
nohup alsa_out -j second_out -r 44100 -d hw:$card_number 2>&1 >> second_out.log &
nohup alsa_in -j second_in -r 44100 -d hw:$card_number 2>&1 >> second_in.log &






