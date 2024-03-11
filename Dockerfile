FROM alpine:3.19
ENV GECKO_DRIVER_VERSION='v0.34.0'
ENV GECKO_DRIVER_ARCHIVE_FILE=geckodriver-$GECKO_DRIVER_VERSION-linux64.tar.gz
ENV GECKO_DRIVER_URL=https://github.com/mozilla/geckodriver/releases/download/$GECKO_DRIVER_VERSION/$GECKO_DRIVER_ARCHIVE_FILE
RUN sh -c "apk update && apk add aws-cli curl firefox python3 py3-pip && pip install -U selenium"
RUN cd /tmp; curl -LJO $GECKO_DRIVER_URL -o $GECKO_DRIVER_ARCHIVE_FILE; tar -xvf $GECKO_DRIVER_ARCHIVE_FILE; rm $GECKO_DRIVER_ARCHIVE_FILE; mv geckodriver /usr/local/bin; chmod +x /usr/local/bin/geckodriver
COPY screenshot.sh make_screenshot.py /
RUN chmod +x screenshot.sh make_screenshot.py