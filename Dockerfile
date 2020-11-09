from debian
run apt-get update
run DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
run DEBIAN_FRONTEND="noninteractive" apt-get -y install keyboard-configuration
run apt-get install -qqy chromium curl xorg imagemagick zip unzip blackbox
run curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip" -o "awscliv2.zip" ; unzip awscliv2.zip ; ./aws/install
run apt-get install -qqy tightvncserver
run apt-get install -qqy firefox-esr
# Unfortunately sideloading doesnt work anymore. Have to install this extension manually...
#run apt-get install -qqy wget
#run wget https://addons.mozilla.org/firefox/downloads/file/718682/google_consent_dialog_remover-61.0-an+fx.xpi -O /usr/lib/mozilla/extensions/\{ec8030f7-c20a-464f-9b0e-13a3a9e97384\}/gcdr.xpi
add screenshot.sh /
run chmod +x screenshot.sh
env USER=root