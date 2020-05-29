#!/bin/sh

set -e
        
killall -9 Xvnc4

# start a server with a specific DISPLAY
export DISPLAY=":45"
vncserver :45 -geometry 2000x2000

# start firefox in this vnc session

# read URLs from a data file in a loop
count=1
while read url
do
    echo "screenshoting $url"
    # send URL to the firefox session
    DISPLAY=":45" blackbox &
    sleep 1
    DISPLAY=":45" chromium --start-maximized $url &

    # take a picture after waiting a bit for the load to finish
    sleep 120
    export filename="image`date +'%y%m%d-%H%M%S'`.png"
    DISPLAY=":45" import -window root img/$filename

    count=`expr $count + 1`
done < url_list.txt

# clean up when done
killall chromium
sleep 5
vncserver -kill :45

echo "Screenshot dopravy vygenerován http://prahounakole.cz/wp-content/doprava/$filename" | mail vratislav.filler@auto-mat.cz -s "Screenshot dopravy vygenerován"
echo "Screenshot dopravy vygenerován http://prahounakole.cz/wp-content/doprava/$filename" | mail petr.dlouhy@auto-mat.cz -s "Screenshot dopravy vygenerován"
