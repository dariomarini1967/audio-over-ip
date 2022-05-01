#! /usr/bin/bash

host_palco=$(egrep "^host_palco" ADDRESSES.cfg|cut -d"=" -f2)
host_regia=$(egrep "^host_regia" ADDRESSES.cfg|cut -d"=" -f2)
profilo_palco=$(egrep "^profilo_palco" ADDRESSES.cfg|cut -d"=" -f2)
profilo_regia=$(egrep "^profilo_regia" ADDRESSES.cfg|cut -d"=" -f2)

echo "host palco (remote PC) is $host_palco"
echo "host regia (this PC) is $host_regia"
echo "profilo palco (remote PC) is $profilo_palco"
echo "profilo regia (this PC) is $profilo_regia"


echo "killing all jack clients"
$(dirname $0)/kill_jack_clients.sh

echo "starting linux-show-player"
lsp_pid=$(pgrep -f linux-show-player)
if [ $? -eq 0 ]
then
	echo "killing existing linux-show-player"
	kill -9 $lsp_pid
fi
nohup linux-show-player -f /home/BASI/ciaparatt/regia.lsp 2>&1 >lsp.log &



sleep 2

echo "starting zita-n2j and zita-j2n"
zita-n2j --buff 30 --jname da_palco $host_regia 4321 2>&1 >>da_palco.log &
zita-j2n --jname a_palco $host_palco 4322 2>&1 >>a_palco.log &






