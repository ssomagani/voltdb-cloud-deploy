#!/usr/bin/env python

# This file is part of VoltDB.
# Copyright (C) 2008-2019 VoltDB Inc.

# VoltDB pristine container
# This container is intended for k8s stateful set deployments

FROM ubuntu:16.04

ARG VOLTDB_DIST_NAME

# Configure required software packages
RUN apt-get clean && \
    apt-get update && \
    apt-get -y --no-install-recommends --no-install-suggests install \
        sudo software-properties-common python-software-properties \
        openjdk-8-jre \
        libxml2-utils procps python vim less curl jq \
        dnsutils net-tools iputils-ping telnet iperf \
        python-pip python-setuptools python-dev build-essential \
        locales && \
    pip install --upgrade pip && \
    pip install --upgrade httplib2

# Set up VoltDB environment variables, locale, timezone.
# Note, can't define locale variables before; pip commands
# complain that the UTF-8 locale does not exist.
ENV VOLTDB_DIST=/opt/$VOLTDB_DIST_NAME \
    PATH=$PATH:/opt/$VOLTDB_DIST_NAME/bin \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    TZ=America/New_York
RUN locale-gen en_US.UTF-8 && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# VoltDB ports, public (first line) and internal (second)
EXPOSE 22 5555 8080 8081 9000 21211 21212 \
       3021 4560 9090 5555

# Create necessary directories, voltdb-kit, voltdb_pristine

# For voltdb bundles and extensions, copy your assets to the corresponding directories in the kit
# prior to building the image.

WORKDIR /opt
RUN mkdir -p $VOLTDB_DIST
COPY ./ $VOLTDB_DIST/
RUN rm -rf $VOLTDB_DIST/doc $VOLTDB_DIST/examples