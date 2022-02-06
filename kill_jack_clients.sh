#! /usr/bin/bash

pid_list=$(pgrep -f '^(zita|alsa)')
if [ $? -ne 0 ]
then
	echo "no additional jack clients are running"
	exit
fi

ps -o pid,cmd -p $pid_list
kill $pid_list
echo "above jack clients have been killed"

