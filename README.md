Script for pulling screenshots of websites

Currently used for scraping google maps' traffic data. For this purpupse you need to have the "Google Consent Dialog Remover". Since sideloading firefox extensions is no longer possible, you need to install this manually before the Docker image can be used.

```
$ docker run -it --shm-size=1g -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v $HOME/.Xauthority:/root/.Xauthority auto0mat/dopravni-screenshots:4 bash
# firefox --new-instance # install the extenstion
# exit
$ docker commit <container-id>
$ dokcer tag <image-id> <tag>
```

The rest of the config is in the [k8s repo](https://github.com/auto-mat/k8s/blob/master/manifests/dopravni-screenshots.yaml). Secrets are in the secret repo ;)
