#!/bin/bash
# If less than a specified track list, add more tracks
set -eu

TRK_NUM=$(curl -s -d '{"jsonrpc": "2.0", "id": 1, "method": "core.tracklist.get_length" }' -H 'Content-Type: application/json' http://localhost:6680/mopidy/rpc|jq '.result')
[ -n "$TRK_NUM" ] && [ $TRK_NUM -lt {{ jukebox__tracks_limit }} ] && /home/{{ jukebox__default_user }}/addtracks.sh
