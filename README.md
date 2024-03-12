# Script for pulling screenshots of websites

Currently used for scraping Google maps' traffic data.

Selenium Gecko driver and Mozilla Firefox web browser version compatibility table:

https://firefox-source-docs.mozilla.org/testing/geckodriver/Support.html

## Build Docker image, run container and make Google Maps screenshot img:

```
$
$ DOCKER_IMG_TAG=auto0mat/dopravni-screenshots:12
# Build Docker img
$ docker buildx build -t $DOCKER_IMG_TAG .

# Run Docker container
$ docker run -it --rm --name traffic-screenshot --mount type=bind,source="$(pwd)",target=/tmp/img/ $DOCKER_IMG_TAG sh

# Make Google Maps screenshot img
/usr/local/bin # ./venv/bin/python make_screenshot.py 2000 2000 $(which geckodriver) "https://www.google.cz/maps/@50.0828639,14.4426597,13z/data=!5m1!1e1?hl=cs&entry=ttu" /tmp/img/img.png

# Check the size of screenshot img
/usr/local/bin # du -hs /tmp/img/img.png
2.6M	/tmp/img/img.png

# Check the screenshot img from the host OS
$ xdg-open img.png
```

The rest of the config is in the [k8s repo](https://github.com/auto-mat/k8s/blob/master/manifests/dopravni-screenshots.yaml). Secrets are in the secret repo.

### Licence

[GNU AGPLv3](https://www.gnu.org/licenses/agpl-3.0.en.html) or later.
