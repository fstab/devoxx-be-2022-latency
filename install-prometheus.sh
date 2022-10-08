#!/bin/bash

set -e

PROMETHEUS_VERSION=2.38.0

if [[ ! -f downloads/prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz ]] ; then
    cd downloads
    echo downloading prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz
    curl -sOL "https://github.com/prometheus/prometheus/releases/download/v$PROMETHEUS_VERSION/prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz"
    cd ..
fi

if [[ ! -x bin/prometheus ]] ; then
    cd bin
    tar xfz ../downloads/prometheus-2.38.0.linux-amd64.tar.gz prometheus-2.38.0.linux-amd64/prometheus --strip-components=1
    cd ..
fi
