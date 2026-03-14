#! /bin/bash

jack_connect "ardour:Bruno/audio_out 1" system:playback_1
jack_connect "ardour:Voce2/audio_out 1" system:playback_2
jack_connect "ardour:Acustica/audio_out 1" system:playback_9
jack_connect "ardour:Ukulele/audio_out 1" system:playback_3
jack_connect "ardour:Clarinetto/audio_out 1" system:playback_4
jack_connect "ardour:Basso/audio_out 1" system:playback_12
jack_connect "ardour:Tastiera/audio_out 1" system:playback_6
jack_connect "ardour:PianoL/audio_out 1" system:playback_7
jack_connect "ardour:PianoR/audio_out 1" system:playback_8
jack_connect "ardour:TomL/audio_out 1" system:playback_13
jack_connect "ardour:TomR/audio_out 1" system:playback_14
jack_connect "ardour:Cassa/audio_out 1" system:playback_15
jack_connect "ardour:Snare/audio_out 1" system:playback_16
