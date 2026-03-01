#! /bin/bash

nohup /usr/bin/x11vnc -rfbport 5901 -forever -display :0 -auth guess -ncache 10 -passwd automat 2>&1 >x11vnc.log &
