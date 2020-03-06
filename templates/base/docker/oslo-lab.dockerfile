# Copyright 2018 Red Hat, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

# python:alpine is 3.{latest}
FROM oslo_lab:base

LABEL maintainer="Hervé Beraud <hberaud@redhat.com>"

# Who I am on github and gerrit
ARG GITHUB
ARG GERRIT

WORKDIR /root/debug

# Install oslo.cache dependencies that we want to debug and to keep
# modification after shutdown to avoid to reinvente the wheel at each reboot
# we want to install:
# - dogpile.cache
# - python-memcached
# - pymemcache
# All these packages are installed in development mode so during execution
# you can switch to the right version of these packages by creating a new
# branch from the right tag or existing branches availables.
# Synchronization and backup are managed by hello.sh and bye.sh
RUN git clone https://github.com/sqlalchemy/dogpile.cache && \
    cd dogpile.cache && \
    git remote add minehttp https://github.com/${GITHUB}/dogpile.cache && \
    git fetch --all && \
    git remote add mine git@github.com:${GITHUB}/dogpile.cache.git && \
    pip install -e . && \
    cd ..

RUN git clone https://github.com/linsomniac/python-memcached && \
    cd python-memcached && \
    git remote add minehttp https://github.com/${GITHUB}/python-memcached && \
    git fetch --all && \
    git remote add mine git@github.com:${GITHUB}/python-memcached.git && \
    pip install -e . && \
    cd ..

RUN git clone https://github.com/pinterest/pymemcache && \
    cd pymemcache && \
    git remote add minehttp https://github.com/${GITHUB}/pymemcache && \
    git fetch --all && \
    git remote add mine git@github.com:${GITHUB}/pymemcache.git && \
    pip install -e . && \
    cd ..

# openstack project attaching git review to work on patch too
RUN git clone https://github.com/openstack/oslo.cache && \
    cd oslo.cache && \
    git remote add minehttp https://github.com/${GITHUB}/oslo.cache && \
    git fetch --all && \
    git remote add mine git@github.com:${GITHUB}/oslo.cache.git && \
    git remote add gerrit ssh://${GERRIT}@review.openstack.org:29418/openstack/oslo.cache && \
    pip install -e . && \
    cd ..

# back to ~
WORKDIR /root
