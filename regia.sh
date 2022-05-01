#! /usr/bin/bash

echo "killing all jack clients"
$(dirname $0)/kill_jack_clients.sh

lsp_pid=$(pgrep -f linux-show-player)
if [ $? -eq 0 ]
then
	echo "killing existing linux-show-play"
	kill -9 $lsp_pid
fi
linux-show-player -f /home/BASI/ciaparatt/regia.lsp

exit


host_palco=$(egrep "^host_palco" ADDRESSES.cfg|cut -d"=" -f2)
host_regia=$(egrep "^host_regia" ADDRESSES.cfg|cut -d"=" -f2)

echo "host palco (remote PC) is $host_palco"
echo "host regia (this PC) is $host_regia"

sleep 2

zita-n2j --buff 30 --jname da_palco $host_regia 4321 2>&1 >>da_palco.log &
zita-j2n --jname a_palco $host_palco 4322 2>&1 >>a_palco.log &






