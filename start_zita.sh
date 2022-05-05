#! /bin/bash

cd $(dirname $0)

if [ "$1" == "" ]
then
	if [ ! -f /etc/avahi/avahi-daemon.conf ]
	then
		echo "/etc/avahi/avahi-daemon.conf not found; cannot understand if this PC is palco or regia"
		exit 1
	fi
	is_palco=$(cat /etc/avahi/avahi-daemon.conf | awk '($1 ~ "^host-name *=.*palco"){print 2}')
elif [ "$1" == "palco" ]
then
	is_palco=1
elif [ "$1" != "regia" ]
then
	echo "Usage: $0 [palco|regia]"
	exit 1
fi

###exec >> zita.log 2>&1
echo $(date)" - is_palco is $is_palco"

host_palco=$(egrep "^host_palco" ADDRESSES.cfg|cut -d"=" -f2)
host_regia=$(egrep "^host_regia" ADDRESSES.cfg|cut -d"=" -f2)

if [ $is_palco ]
then
	echo "starting zita for PALCO"
	zita-j2n --jname a_regia $host_regia 4321 2>&1 >>a_regia.log &
	zita-n2j --buff 30 --jname da_regia $host_palco 4322 2>&1 >>da_regia.log 2>&1 &
	# ./start_lsp.sh &
else
	echo "starting zita for REGIA"
	zita-n2j --buff 30 --jname da_palco $host_regia 4321 2>&1 >>da_palco.log &
	zita-j2n --jname a_palco $host_palco 4322 2>&1 >>a_palco.log &
fi

