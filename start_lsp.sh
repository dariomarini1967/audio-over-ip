#! /usr/bin/bash

echo "starting linux-show-player"
lsp_pid=$(pgrep -f linux-show-player)
if [ $? -eq 0 ]
then
	echo "killing existing linux-show-player"
	kill -9 $lsp_pid
fi
nohup linux-show-player -f /home/BASI/ciaparatt/regia.lsp 2>&1 >lsp.log &
