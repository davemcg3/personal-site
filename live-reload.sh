#!/bin/sh
RELOAD_FILE=/tmp/live-reload

echo "Content-Type: text/event-stream"
echo "Cache-Control: no-cache"
echo "Connection: keep-alive"
echo "Access-Control-Allow-Origin: *"
echo

while true; do
    if [ -f "$RELOAD_FILE" ]; then
        echo "data: reload"
        echo
        rm "$RELOAD_FILE"
    fi
    sleep 0.1
done 
