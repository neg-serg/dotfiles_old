#!/bin/bash
wget -c `wget -O - $1|egrep -o "http://rghost.ru/download/.*\" "|cut -f1 -d '"'`
