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
# ==================================================================
# Base image for oslo.labs
# All labs will inherit from this one.
# ==================================================================
FROM python:alpine

LABEL maintainer="Hervé Beraud <hberaud@redhat.com>"

RUN apk update
# git is required by pbr to install local package
# the purpose of this environment is to install local
# packages for development so we need git too.
RUN apk add \
    vim \
    git \
    musl-dev \
    bash \
    linux-headers \
    libc-dev \
    zsh \
    zsh-vcs \
    busybox-extras \
    openssh \
    gcc

COPY requirements.txt /

RUN pip install -r /requirements.txt

# Setup a fake server to keep container alive to play with him
RUN mkdir /flask
RUN mkdir /oslo-lab
COPY loop.py /flask
COPY environment/hello.sh /oslo-lab/hello.sh
COPY environment/ciao.sh /oslo-lab/ciao.sh
COPY environment/motd.sh /etc/motd.sh
COPY environment/.vimrc /root/.vimrc
COPY environment/.vim /root/.vim
COPY environment/.zshrc /root/.zshrc
COPY environment/.oh-my-zsh /root/.oh-my-zsh
COPY environment/.aliases /root/.aliases

EXPOSE 5000

RUN mkdir /root/debug
# Who I am on github
ARG GITHUB
ARG GERRIT

WORKDIR /root
ENTRYPOINT ["python", "/flask/loop.py"]
