#! /usr/bin/bash -x

ip_regia=$(ip -br a | grep UP | head -1 | sed -E 's/.+UP +//g' | sed -E 's/\/.+$//g')
ip_palco=192.168.1.8
utente_regia=marini

killall zita-j2n zita-n2j
sleep 2
zita-n2j --buff 100 --jname da_palco $ip_regia 4321 >/dev/null 2>&1 &
zita-j2n --jname a_palco $ip_palco 4322 >/dev/null 2>&1 &





