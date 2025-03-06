#!/bin/bash

# Start xvfb
Xvfb :99 -screen 0 1024x768x16 &

# Start x11vnc
x11vnc -display :99 -forever -nopw -create &

# Start noVNC
/usr/share/novnc/utils/launch.sh --vnc localhost:5900 &

# Run SpiderFoot
DISPLAY=:99 python3 sf.py -l 127.0.0.1:5001
