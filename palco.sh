#! /usr/bin/bash

echo "killing all jack clients"
$(dirname $0)/kill_jack_clients.sh

host_palco=$(ip -br a | awk '($2=="UP"){gsub("/.+$","",$3);print $3}')
#host_palco=192.168.1.16
echo "host palco (this PC) is $host_palco"

#host_regia=lenovo
host_regia=192.168.0.100
echo "host regia (remote PC) is $host_regia"

sleep 2

nohup zita-j2n --jname a_regia $host_regia 4321 2>&1 >>a_regia.log &
sleep 1
nohup zita-n2j --buff 30 --jname da_regia $host_palco 4322 2>&1 >>da_regia.log 2>&1 &

exit

# aggiunge X18 come seconda scheda audio
nohup alsa_out -j x18_rec -r 48000 -d hw:0  2>&1 >>x18_rec.log &
nohup alsa_in -j x18_play -r 48000 -d hw:0 2>&1 >>x18_play.log &






