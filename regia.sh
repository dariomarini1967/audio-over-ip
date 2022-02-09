#! /usr/bin/bash

echo "killing all jack clients"
$(dirname $0)/kill_jack_clients.sh

#host_palco=dario-pc
host_palco=192.168.0.101
echo "host palco (remote PC) is $host_palco"

host_regia=$(ip -br a | awk '($2=="UP"){gsub("/.+$","",$3);print $3}')
#host_regia=192.168.1.8
echo "host regia (this PC) is $host_regia"


sleep 2

zita-n2j --buff 30 --jname da_palco $host_regia 4321 2>&1 >>da_palco.log &
zita-j2n --jname a_palco $host_palco 4322 2>&1 >>a_palco.log &






