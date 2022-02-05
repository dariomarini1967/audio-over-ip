#! /usr/bin/bash -x

ip_palco=$(ip -br a | grep UP | head -1 | sed -E 's/.+UP +//g' | sed -E 's/\/.+$//g')
ip_regia=192.168.1.9

killall zita-j2n zita-n2j
sleep 2
zita-j2n --jname a_regia $ip_regia 4321 &
zita-n2j --buff 10 --jname da_regia $ip_palco 4322 &





