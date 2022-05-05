#! /usr/bin/bash

curr_dir=$(dirname $0)
lsp_pid=$(pgrep -f linux-show-player)
if [ $? -eq 0 ]
then
	echo "killing existing linux-show-player"
	kill -9 $lsp_pid
fi
palco_or_regia=$($curr_dir/palco_or_regia.pl)
if [ $? -eq 0 ]
then
	echo "starting linux-show-player on $palco_or_regia"
	linux-show-player -f /home/BASI/ciaparatt/$palco_or_regia.lsp 2>&1 >$HOME/lsp.log &
else
	echo "could not understand if this PC is PALCO or REGIA"
fi
