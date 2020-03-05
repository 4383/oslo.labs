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
    linux-headers \
    libc-dev \
    zsh \
    gcc

COPY requirements.txt /

RUN pip install -r /requirements.txt

# Setup a fake server to keep container alive to play with him
RUN mkdir /flask
COPY app.py /flask

EXPOSE 5000

WORKDIR /root
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
ENTRYPOINT ["python", "/flask/app.py"]
