#!/bin/sh

set -e
HEIGTH=2000
WIDTH=2000

curl -s https://raw.githubusercontent.com/auto-mat/doprava-screenshot/master/url_list.txt | while read url
do
    echo "screenshoting $url"
    # send URL to the firefox session
    sleep 1
    mkdir -p img/
    filename="image`date +'%y%m%d-%H%M%S'`.png"
    img_path="/img/$filename"
    ./make_screenshot.py $HEIGTH $WIDTH $(which geckodriver) $url $img_path
    # take a picture after waiting a bit for the load to finish
    aws s3 cp $img_path s3://doprava-screenshots/img/$(echo $url | sed -e 's/[^A-Za-z0-9._-]/_/g')/$filename
done

for recipient in $RECIPIENTS
do
    aws ses send-email --from root@auto-mat.cz --to $recipient --subject "Screenshot dopravy vygenerován" --text "http://doprava-screenshots.s3-website-eu-west-1.amazonaws.com"
done
