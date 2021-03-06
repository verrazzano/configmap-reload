#!/bin/sh

# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

set -x

BASEIMAGE="container-registry.oracle.com/os/oraclelinux:7.9@sha256:5aa7df08f9ab8cd6237223b0b6c5fd605f140164235b462a01e8b9d56fb03daf"

if [ -z "${DOCKER_IMAGE_NAME}" ] ; then
    echo "Environment variable DOCKER_IMAGE_NAME not set"
    exit 1
fi
if [ -z "${DOCKER_IMAGE_TAG}" ] ; then
    echo "Environment variable DOCKER_IMAGE_TAG not set"
    exit 1
fi

make out/configmap-reload-linux-amd64

docker build \
    --build-arg BASEIMAGE="${BASEIMAGE}" \
    --build-arg BINARY="configmap-reload-linux-amd64" \
    -t "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" .
