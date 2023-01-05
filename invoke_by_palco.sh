#! /usr/bin/bash

curr_dir=$(dirname $0)
cd $curr_dir
to_be_invoked=$1
palco_or_regia=$($curr_dir/palco_or_regia.pl)
if [ $? -ne 0 ]
then
	echo "could not understand if this PC is PALCO or REGIA"
	exit 1
fi
if [ "$palco_or_regia" == "palco" ]
then
	$to_be_invoked
else
	host_palco=$(egrep "^host_palco" $curr_dir/ADDRESSES.cfg|cut -d"=" -f2)
	ssh -t -Y tecnici@$host_palco "(cd audio-over-ip;$to_be_invoked)"
fi





