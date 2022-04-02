<div id="top"></div>

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![License][license-shield]][license-url]
[![Build][build-shield]][build-url]


<!-- PROJECT LOGO -->
<br />
<div align="center">
<!--   <a href="https://github.com/GuangchenJ/cuda-dev">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a> -->

<h3 align="center">cuda-dev</h3>

  <p align="center">
    TensorFlow development environment for docker container
    <br />
    <a href="https://github.com/GuangchenJ/cuda-dev"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/GuangchenJ/cuda-dev">View Demo</a>
    ·
    <a href="https://github.com/GuangchenJ/cuda-dev/issues">Report Bug</a>
    ·
    <a href="https://github.com/GuangchenJ/cuda-dev/issues">Request Feature</a>
  </p>
</div>

## Description

This image is based on [nvidia/cuda](https://hub.docker.com/r/nvidia/cuda/) and used for CUDA development and provides the `SSH` service. You can ssh into container to use the CUDA which in container as CLion remote development.

## Details

We use docker compose to manage the container, the container will expose the ssh port and jupyter port

- `8122` use to expose the ssh port
- `/data/trt-dev-workspace` directory maps to `/workspace` in the container default

## Request

1. Install [Docker](https://docs.docker.com/get-docker/) on your local *host* machine.
2. For GPU support on Linux, [install NVIDIA Docker support](https://github.com/NVIDIA/nvidia-docker)
    - Take note of your Docker version with `docker -v`. Versions **earlier than** 19.03 require nvidia-docker2 and the `--runtime=nvidia` flag. On versions **including and after** 19.03, you will use the `nvidia-container-toolkit` package and the `--gpus all` flag. Both options are documented on the page linked above.
    - [**NVIDIA Container Toolkit** Installation Guide (Docker)](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)

## How To Use

- Make sure you have [Docker](https://www.docker.com/get-started) and [Docker-Compose](https://docs.docker.com/compose/) installed

How to start the container?

````shell
# Set the new password
export pwd=${new_password}
# run the container
docker-compose up -d
````

Or use `start.sh` directly
```sheel
sh start.sh
```

- Use `docker-compose up -d` to run the container
- use `docker-compose down` to stop the container

## Source

There are several mirror repository addresses as follows, which one is faster to use

- Docker Hub: [https://hub.docker.com/r/guangchenj/cuda-dev](https://hub.docker.com/r/guangchenj/cuda-dev)
- Ghcr: [https://github.com/GuangchenJ/cuda-dev/pkgs/container/cuda-dev](https://github.com/GuangchenJ/cuda-dev/pkgs/container/cuda-dev)

Change your repository address in docker-compose.yml, default Docker Hub

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/GuangchenJ/cuda-dev.svg?style=for-the-badge
[contributors-url]: https://github.com/GuangchenJ/cuda-dev/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/GuangchenJ/cuda-dev.svg?style=for-the-badge
[forks-url]: https://github.com/GuangchenJ/cuda-dev/network/members
[stars-shield]: https://img.shields.io/github/stars/GuangchenJ/cuda-dev.svg?style=for-the-badge
[stars-url]: https://github.com/GuangchenJ/cuda-dev/stargazers
[issues-shield]: https://img.shields.io/github/issues/GuangchenJ/cuda-dev.svg?style=for-the-badge
[issues-url]: https://github.com/GuangchenJ/cuda-dev/issues
[license-shield]: https://img.shields.io/github/license/GuangchenJ/cuda-dev.svg?style=for-the-badge
[license-url]: https://github.com/GuangchenJ/cuda-dev/blob/master/LICENSE
[build-shield]: https://img.shields.io/github/workflow/status/GuangchenJ/cuda-dev/Docker%20Deploy?style=for-the-badge
[build-url]: https://github.com/GuangchenJ/cuda-dev/actions/workflows/docker-publish.yml
