#! /usr/bin/bash -x

ip_regia=$(ip -br a | grep UP | head -1 | sed -E 's/.+UP +//g' | sed -E 's/\/.+$//g')
ip_palco=dario-pc

killall zita-j2n zita-n2j
sleep 2
zita-n2j --buff 30 --jname da_palco $ip_regia 4321 2>&1 >>da_palco.log &
zita-j2n --jname a_palco $ip_palco 4322 2>&1 >>a_palco.log &






