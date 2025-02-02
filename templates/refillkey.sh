#!/bin/bash
# Refill USB key

KEY_NAME={{ jukebox__refill_keyname }}

urldecode () {
    python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))" "$1"
}

say() {
    espeak -a 50 -p 95 "$@" 2>/dev/null
}

say "USB detected"
sleep 1s

# 1 - Check if this is a Music key
if [ ! -d /media/francois/${KEY_NAME} ]
then
    say 'Wrong key, doing nothing!'
    exit 0
fi

# 2 - Remove current music
say 'Removing current music'
rm -fr /media/francois/${KEY_NAME}/*

# 3 - Extract track list into temp file
TRACKS_FILE=$(mktemp -p /tmp tkXXXXXXX.tracks)
curl -s -d '{"jsonrpc": "2.0", "id": 1, "method": "core.library.browse", "params" : {"uri": "local:directory?type=track" }}' \
     -H 'Content-Type: application/json' http://localhost:6680/mopidy/rpc \
    | jq '.result'|grep '"uri":' | sed -e 's/.*"uri": "//;s/",//' > $TRACKS_FILE

# 4 - Compute the tracks number
TRACKS_NUMBER=$(wc -l $TRACKS_FILE|sed -e 's/ .*//')

# 5 - Create a random list
TRACKS=""
for n in $(seq 1 {{ jukebox__refill_qty }})
do
    TRACKS="${TRACKS}$(( $RANDOM * $TRACKS_NUMBER / 32768 + 1))p;"
done

# 6 - Copy tracks to USB
INDEX=1
say 'Copying music.'
sed -n "$TRACKS" $TRACKS_FILE | while read TRK
do
    SName=$(echo $TRK|sed -e 's/local:track://')
    # echo "Decoding $SName..."
    SName=$(urldecode "${SName}")
    DName=$(printf "%04d" $INDEX)
    DName="/media/francois/${KEY_NAME}/${DName} - "$(echo ${SName}|sed -e 's/\// - /g')
    SName="{{ jukebox__media_dir }}/$SName"
    cp "$SName" "$DName"
    INDEX=$(($INDEX + 1))
done

say 'Unmounting key.'
umount /media/francois/${KEY_NAME}
sleep 1s

say 'You can remove the key.'

# 5 - Remove temp file
rm -f $TRACKS_FILE
