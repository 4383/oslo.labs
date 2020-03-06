# oslo.labs

Openstack Oslo labs

oslo.labs aim to help you to debug Openstack Oslo libraries, by setting up
automatically a complete environment ready for hacking and debug.

Labs provide some preconfigured scenario to help you to test and debug
oslo's libraries and also oslo's projects requirements like `python-memcached`,
`dogpile.cache`, etc...

Each change made on an oslo library or on requirements in your lab are
synchronized with your github forks of each projects, this allow you
to quickly iterate on your changes in your lab, and when you think you
are ready you can rebase all your changes properly to a dedicated branch
ready for review.

## Install

```sh
$ git clone git@github.com:4383/oslo.labs.git
$ cd oslo.labs
```
## Usage

Choose the lab you want to use:

```sh
$ ./list.sh
oslo.cache's labs:
-  memcache_pool_backend
```

Start your lab:

```sh
$ ./run.sh oslo.cache/memcache_pool_backend
...
Creating network "memcache_pool_backend_default" with the default driver
Creating network "memcache_pool_backend_dev-network" with driver "bridge"
Creating memcache_pool_backend_oslo-lab_1 ... done
Creating memcached2                       ... done
Creating memcached1                       ... done
Creating oslo.cache-memcache_pool_backend.lab ... done
==============================================================
lab successfully settled!
==============================================================
Join your lab by using:
    docker exec -it oslo.cache-memcache_pool_backend.lab /bin/zsh
Stop your lab by using:
    docker-compose -f oslo.cache/memcache_pool_backend/docker-compose-lab.yml down
==============================================================
```

Now enter in your lab:
```sh
$ docker exec -it oslo.cache-memcache_pool_backend.lab /bin/zsh
lab $ python lab/app.py
lab $ ls ~/debug # here are all the libs you may want to modify for your tests
```

Create a new lab from an existing template:
```sh
$ # list existing templates
$ ./new --list
$ # create a new lab named testXYZ in the oslo.cache scope
$ # from the default template
$ ./new --lab-group=oslo.cache testXYZ
$ # more options are availables
$ ./new -h
```

## Labs

## Overview

A lab is an environment automatically setup with many services.
Oslo libraries aim to to give an abstraction between services and users.
A services could be a memcached server or rabbitmq server by example, and
oslo's users are commonly openstack services like nova, neutron, etc...

A lab provide some scripts to give you an abstraction and emulate openstack
services.
