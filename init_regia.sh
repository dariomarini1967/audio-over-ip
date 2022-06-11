#! /usr/bin/bash

curr_dir=$(dirname $0)
palco_or_regia=$($curr_dir/palco_or_regia.pl)
if [ "$palco_or_regia" != "regia" ]
then
	echo "$0 must be launched on REGIA pc"
	exit 1
fi
host_palco=$(egrep "^host_palco" ADDRESSES.cfg|cut -d"=" -f2)
ssh -Y tecnici@$host_palco audio-over-ip/start_lsp.sh &
jack_mixer -c $curr_dir/mixer_regia.xml cuffie &
