#! /bin/bash

tigervncserver :5 -localhost no -desktop Palco -rfbauth /home/tecnici/.vnc/passwd -geometry 1920x1080 -xstartup startplasma-x11
