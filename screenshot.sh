#!/bin/sh

set -e
# Configure VNC password https://stackoverflow.com/questions/30606655/set-up-tightvnc-programmatically-with-bash
umask 0077                                        # use safe default permissions
mkdir -p "$HOME/.vnc"                             # create config directory
chmod go-rwx "$HOME/.vnc"                         # enforce safe permissions
vncpasswd -f > "$HOME/.vnc/passwd" <<EOF
"insecurepassword"
EOF

# start a server with a specific DISPLAY
export DISPLAY=":45"
vncserver :45 -geometry 2000x2000

curl -s https://raw.githubusercontent.com/auto-mat/doprava-screenshot/master/url_list.txt | while read url
do
    echo "screenshoting $url"
    # send URL to the firefox session
    sleep 1
    DISPLAY=":45" firefox --kiosk $url &

    # take a picture after waiting a bit for the load to finish
    sleep 120
    export filename="image`date +'%y%m%d-%H%M%S'`.png"
    mkdir -p img/
    DISPLAY=":45" import -window root img/$filename
    aws s3 cp img/$filename s3://doprava-screenshots/img/$(echo $url | sed -e 's/[^A-Za-z0-9._-]/_/g')/$filename
done

for recipient in $RECIPIENTS
do
    aws ses send-email --from root@auto-mat.cz --to $recipient --subject "Screenshot dopravy vygenerován" --text "http://doprava-screenshots.s3-website-eu-west-1.amazonaws.com/img/"
done
