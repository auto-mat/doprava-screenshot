FROM alpine:3.19
ENV GECKO_DRIVER_VERSION=v0.34.0
ENV GECKO_DRIVER_ARCHIVE_FILE=geckodriver-$GECKO_DRIVER_VERSION-linux64.tar.gz
ENV GECKO_DRIVER_URL=https://github.com/mozilla/geckodriver/releases/download/$GECKO_DRIVER_VERSION/$GECKO_DRIVER_ARCHIVE_FILE \
    WORK_DIR=/usr/local/bin/
WORKDIR $WORK_DIR
RUN apk update \
    && apk add --no-cache aws-cli curl firefox python3 py3-pip unzip \
    && python3 -m venv ./venv \
    && . ./venv/bin/activate \
    && pip install selenium==4.0.0 \
    && deactivate
RUN curl -LJO $GECKO_DRIVER_URL -o $GECKO_DRIVER_ARCHIVE_FILE \
    && tar -xvf $GECKO_DRIVER_ARCHIVE_FILE \
    && rm $GECKO_DRIVER_ARCHIVE_FILE \
    && chmod +x geckodriver
COPY screenshot.sh make_screenshot.py .
RUN chmod +x screenshot.sh make_screenshot.py