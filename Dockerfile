from debian
env GECKO_DRIVER_VERSION='v0.29.1'
env GECKO_DRIVER_ARCHIVE_FILE=geckodriver-$GECKO_DRIVER_VERSION-linux64.tar.gz
env GECKO_DRIVER_URL=https://github.com/mozilla/geckodriver/releases/download/$GECKO_DRIVER_VERSION/$GECKO_DRIVER_ARCHIVE_FILE
run apt-get update
run DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
run DEBIAN_FRONTEND="noninteractive" apt-get -y install keyboard-configuration
run apt-get install -qqy chromium curl xorg imagemagick zip unzip blackbox python3 python3-selenium
run curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip" -o "awscliv2.zip" ; unzip awscliv2.zip ; ./aws/install
run apt-get install -qqy tightvncserver
run apt-get install -qqy firefox-esr
run cd /tmp; curl -LJO $GECKO_DRIVER_URL -o $GECKO_DRIVER_ARCHIVE_FILE; tar -xvf $GECKO_DRIVER_ARCHIVE_FILE; rm $GECKO_DRIVER_ARCHIVE_FILE; mv geckodriver /usr/local/bin; chmod +x /usr/local/bin/geckodriver
# Unfortunately sideloading doesnt work anymore. Have to install this extension manually...
#run apt-get install -qqy wget
#run wget https://addons.mozilla.org/firefox/downloads/file/718682/google_consent_dialog_remover-61.0-an+fx.xpi -O /usr/lib/mozilla/extensions/\{ec8030f7-c20a-464f-9b0e-13a3a9e97384\}/gcdr.xpi
copy screenshot.sh make_screenshot.py /
run chmod +x screenshot.sh make_screenshot.py
env USER=root