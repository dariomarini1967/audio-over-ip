#! /usr/bin/bash

host_palco=$(egrep "^host_palco" ADDRESSES.cfg|cut -d"=" -f2)
host_regia=$(egrep "^host_regia" ADDRESSES.cfg|cut -d"=" -f2)
profilo_palco=$(egrep "^profilo_palco" ADDRESSES.cfg|cut -d"=" -f2)
profilo_regia=$(egrep "^profilo_regia" ADDRESSES.cfg|cut -d"=" -f2)

echo "host palco (this PC) is $host_palco"
echo "host regia (remote PC) is $host_regia"
echo "profilo palco (this PC) is $profilo_palco"
echo "profilo regia (remote PC) is $profilo_regia"

echo "killing all jack clients"
$(dirname $0)/kill_jack_clients.sh

echo "starting qjackctl"
qjackctl_pid=$(pgrep -f qjackctl)
if [ $? -eq 0 ]
then
        echo "killing existing qjackctl"
        kill -9 $qjackctl_pid
fi
nohup qjackctl -p $profilo_palco -s 2>&1 >qjackctl.log



sleep 2

echo "starting zita-n2j and zita-j2n"
nohup zita-j2n --jname a_regia $host_regia 4321 2>&1 >>a_regia.log &
nohup zita-n2j --buff 30 --jname da_regia $host_palco 4322 2>&1 >>da_regia.log 2>&1 &


