#!/bin/sh
arecord -F 5 -D hw:0,0 -t wav -f dat > ~/tmp.wav
