#!/bin/sh

free -m | awk '/\-\/\+ buffers\/cache/ {print $3}'
