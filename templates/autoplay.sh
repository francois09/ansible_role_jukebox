#!/bin/bash
set -eu
{% if jukebox__autoplay_random|default(False) %}
# Put some files for first playback

# 1 - Run track adder
/home/{{ jukebox__default_user }}/addtracks.sh

# 2 - Set consume mode
curl -s -d '{"jsonrpc": "2.0", "id": 1, "method": "core.tracklist.set_consume", "params" : {"value" : true }}' -H 'Content-Type: application/json' http://localhost:6680/mopidy/rpc > /dev/null

# 3 - Set volume to specifif value
curl -s -d '{"jsonrpc": "2.0", "id": 1, "method": "core.mixer.set_volume", "params" : {"volume" : {{ jukebox__initial_volume }} }}' -H 'Content-Type: application/json' http://localhost:6680/mopidy/rpc > /dev/null

# 4 - Play !
curl -s -d '{"jsonrpc": "2.0", "id": 1, "method": "core.playback.play"}' -H 'Content-Type: application/json' http://localhost:6680/mopidy/rpc > /dev/null

{% endif %}
