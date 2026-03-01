#! /bin/bash

exec >> $(dirname $0)/minimal_audio.log 2>&1
systemctl --user stop pulseaudio.socket pulseaudio.service
pkill jackd
pkill zita-j2n
export JACK_NO_AUDIO_RESERVATION=1
/usr/bin/jackd -dalsa -dhw:UA1EX -r44100 -p512 -n2 &
sleep 2
/usr/bin/zita-j2n --jname a_regia jolly.local 4321 &
sleep 2
jack_connect system:capture_1 a_regia:in_1
jack_connect system:capture_2 a_regia:in_2


