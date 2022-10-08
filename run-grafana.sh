#!/bin/bash

GRAFANA_VERSION=9.1.6
LOGFILE=logs/$(date '+%Y-%m-%d')-grafana.log

echo >> "$LOGFILE"
echo "$(date)" >> "$LOGFILE"
echo >> "$LOGFILE"

cd bin/grafana-$GRAFANA_VERSION
./bin/grafana-server 2>&1 | tee -a "../../$LOGFILE"
