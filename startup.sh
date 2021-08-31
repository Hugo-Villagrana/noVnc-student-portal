#!/bin/sh

export DISPLAY=:99
xvfb-run --auth-file=Xauthority openbox-session &
x11vnc -forever -display :99 -auth /home/user/Xauthority

