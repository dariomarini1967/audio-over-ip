#! /bin/bash

nohup sudo /usr/bin/x11vnc -forever -display :0 -auth guess -ncache 10 -passwd automat 2>&1 >x11vnc.log &
