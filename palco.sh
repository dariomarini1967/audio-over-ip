#! /usr/bin/bash 

host_palco=$(host $(hostname)|head -1|sed  -E 's/^.+ //g')
host_regia=lenovo

killall zita-j2n zita-n2j
sleep 2
nohup zita-j2n --jname a_regia $host_regia 4321 2>&1 >>a_regia.log &
nohup zita-n2j --buff 30 --jname da_regia $host_palco 4322 2>&1 >>da_regia.log 2>&1 &

# aggiunge X18 come seconda scheda audio
killall alsa_out alsa_in
nohup alsa_out -j x18_rec -r 48000 -d hw:0  2>&1 >>x18_rec.log &
nohup alsa_in -j x18_play -r 48000 -d hw:0 2>&1 >>x18_play.log &






