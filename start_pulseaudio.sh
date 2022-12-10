#! /bin/bash

# should be useless
systemctl --user start pulseaudio.socket pulseaudio.service

pactl load-module module-jack-sink channels=2
pactl load-module module-jack-source channels=2

