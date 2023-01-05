#! /usr/bin/bash

exec 2>&1 >$HOME/lsp.log
curr_dir=$(dirname $0)
lsp_pid=$(pgrep -f linux-show-player)
if [ $? -eq 0 ]
then
	echo "killing existing linux-show-player"
	kill -9 $lsp_pid
fi
echo "starting linux-show-player on palco"
linux-show-player -f $HOME/BASI/ciaparatt/palco.lsp 2>&1 >>$HOME/lsp.log &
