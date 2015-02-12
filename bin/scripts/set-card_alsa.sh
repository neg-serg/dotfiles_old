#!/bin/sh
#
# Copyright (c) 2008, Benjamin Peter <BenjaminPeter@arcor.de>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
# * Neither the name of the author nor the
# names of its contributors may be used to endorse or promote products
# derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY Benjamin Peter ''AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL Benjamin Peter BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

CARDIDENT="intel"
PROCFILE="/proc/asound/modules"
ALSACONFIG="/etc/asound.conf"

function set_alsa_card {
  if [ ! -e "$PROCFILE" ]; then
echo "ERROR: ALSA information file '$PROCFILE' does not exist."
    exit
fi
if [ ! -r "$PROCFILE" ]; then
echo "ERROR: ALSA information file '$PROCFILE' not readable."
    exit
fi
if [ -e "$ALSACONFIG" ]; then
if [ ! -w "$ALSACONFIG" ]; then
echo "ERROR: ALSA configuration file '$ALSACONFIG' is not writable."
      exit
fi
fi
CARDID=$(grep $CARDIDENT $PROCFILE | cut -d' ' -f 2)
  DATE=$(date)
  
  (
  cat <<HERE
# Warning, this file is created by script - do not modify
# or deal with lost changes.
#
# This config makes '$CARDIDENT' the first card.
#
# Updated: $DATE

pcm.!default {
type hw
card $CARDID
}

ctl.!default {
type hw
card $CARDID
}
HERE
  ) > "$ALSACONFIG"
}

case "$1" in
  start)
    echo "Setting correct ALSA card."
    set_alsa_card
    ;;
  stop)
    ;;
  list)
    cat $PROCFILE
    ;;
  *)
    echo "Usage: $0 {start|stop|list}"
    exit 1
    ;;
esac
