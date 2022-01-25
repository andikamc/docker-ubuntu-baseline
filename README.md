# Ubuntu Baseline Image for Docker Container
[![Build Status](https://travis-ci.org/andikamc/docker-ubuntu-baseline.svg?branch=master)](https://travis-ci.org/andikamc/docker-ubuntu-baseline)

Run SystemD inside Ubuntu Docker Container

### Baseline images
- ubuntu-bionic-oci-amd64-root
- ubuntu-focal-oci-amd64-root

### Installed Features
- systemd
- rsyslog
- cron
- dos2unix
- git
- userd handler


### Usage
1. Run the container as a daemon
    ```sh
    docker run -d -it --name docker-ubuntu-baseline && \
    --restart always && \
    --tmpfs /tmp --tmpfs /run --tmpfs /run/lock && \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro && \
    sadaindonesia/ubuntu-baseline:tagname
    ``` 
    or if it doesn't work
    
    ```sh
    docker run -d -it --name docker-ubuntu-baseline && \
    -- restart always && \
    --privileged && \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro && \
    sadaindonesia/ubuntu-baseline:tagname
    ```
    
2. Enter to the container
    ```sh
    docker exec -it docker-ubuntu-baseline bash
    ```
    
2. Remove to the container
    ```sh
    docker rm -f docker-ubuntu-baseline
    ```

## Docker

Very easy to install and deploy in a Docker container.

By default, the Docker will expose port 8080, so change this within the
Dockerfile if necessary. When ready, simply use the Dockerfile to
build the image.

```sh
cd docker-ubuntu-baseline
docker build -t <youruser>/docker-ubuntu-baseline:${package.json.version} .
```

This will create the image and pull in the necessary dependencies.
Be sure to swap out `${package.json.version}` with the actual
version.

Once done, run the Docker image and map the port to whatever you wish on
your host. In this example, we simply map port 8000 of the host to
port 8080 of the Docker (or whatever port was exposed in the Dockerfile):

```sh
docker run -d -it -p 8000:8080 --restart=always --privileged --name=docker-ubuntu-baseline <youruser>/docker-ubuntu-baseline:${package.json.version}
```

> Note: `--capt-add=SYS-ADMIN` is required for PDF rendering.

Verify the deployment by navigating to your server address in
your preferred browser.

```sh
127.0.0.1:8000
```

### License

MIT

**Free Software, Hell Yeah!**
