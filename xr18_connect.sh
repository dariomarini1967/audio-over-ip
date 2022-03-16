#! /usr/bin/bash

# aggiunge X18 come seconda scheda audio
nohup alsa_out -j x18_rec -r 44100 -d hw:3  2>&1 >>x18_rec.log &
nohup alsa_in -j x18_play -r 44100 -d hw:3 2>&1 >>x18_play.log &






