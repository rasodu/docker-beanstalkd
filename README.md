# docker-beanstalkd

Beanstalk is a simple, fast work queue.

Its interface is generic, but was originally designed for reducing the latency of page views in high-volume web applications by running time-consuming tasks asynchronously.

# Usage

This docker image is available as a [build on the docker hub](https://hub.docker.com/r/kusmierz/beanstalkd/), so there's no setup required.
Using this image for the first time will start a download automatically.
Further runs will be immediate, as the image will be cached locally.

The recommended way to run this container looks like this:

```bash
$ sudo docker run -d -p 11300:11300 kusmierz/beanstalkd
```

The above example exposes the Beanstalk on port 11300, so that you can use it in your application.

You can also use docker's `links` to link beanstalkd service to your container.

