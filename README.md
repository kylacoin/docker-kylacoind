Kylacoind for Docker
===================

[![Docker Stars](https://img.shields.io/docker/stars/kylacoin/kylacoind.svg)](https://hub.docker.com/r/kylacoin/kylacoind/)
[![Docker Pulls](https://img.shields.io/docker/pulls/kylacoin/kylacoind.svg)](https://hub.docker.com/r/kylacoin/kylacoind/)
[![Build Status](https://travis-ci.org/kylacoin/docker-kylacoind.svg?branch=master)](https://travis-ci.org/kylacoin/docker-kylacoind/)

Docker image that runs the Kylacoin kylacoind node in a container for easy deployment.


Requirements
------------

* Physical machine, cloud instance, or VPS that supports Docker (i.e. [Vultr](https://www.vultr.com/), [Digital Ocean](https://www.digitalocean.com/), KVM or XEN based VMs) running Ubuntu 14.04 or later (*not OpenVZ containers!*)
* At least 2 GB to store the block chain files
* At least 1 GB RAM + 2 GB swap file

Recommended and tested on unadvertised (only shown within control panel) [Vultr](https://www.vultr.com/).  Vultr also *accepts crypto payments*!


Really Fast Quick Start
-----------------------

One liner for Ubuntu 14.04 LTS machines with JSON-RPC enabled on localhost and adds upstart init script:

    curl https://raw.githubusercontent.com/kylacoin/docker-kylacoind/master/bootstrap-host.sh | sh -s trusty


Quick Start
-----------

1. Create a `kylacoind-data` volume to persist the kylacoind blockchain data, should exit immediately.  The `kylacoind-data` container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):

        docker volume create --name=kylacoind-data
        docker run -v kylacoind-data:/kylacoin/.kylacoin --name=kylacoind-node -d \
            -p 5111:5111 \
            -p 127.0.0.1:5110:5110 \
            kylacoin/kylacoind

2. Verify that the container is running and kylacoind node is downloading the blockchain

        $ docker ps
        CONTAINER ID        IMAGE                         COMMAND             CREATED             STATUS              PORTS                                              NAMES
        d0e1076b2dca        kylacoin/kylacoind:latest     "kcn_oneshot"       2 seconds ago       Up 1 seconds        127.0.0.1:5110->5110/tcp, 0.0.0.0:5111->5111/tcp   kylacoind-node

3. You can then access the daemon's output thanks to the [docker logs command]( https://docs.docker.com/reference/commandline/cli/#logs)

        docker logs -f kylacoind-node

4. Install optional init scripts for upstart and systemd are in the `init` directory.


Documentation
-------------

* Additional documentation in the [docs folder](docs).
