#!/bin/bash

LOGFILE=logs/$(date '+%Y-%m-%d')-prometheus.log

echo >> "$LOGFILE"
echo "$(date)" >> "$LOGFILE"
echo >> "$LOGFILE"

./bin/prometheus 2>&1 | tee -a "$LOGFILE"
