#!/bin/bash

LOGFILE=logs/$(date '+%Y-%m-%d')-hello-world-app.log

echo >> "$LOGFILE"
echo "$(date)" >> "$LOGFILE"
echo >> "$LOGFILE"

java -jar ./hello-world-app/target/hello-world-app-1.0.0-SNAPSHOT.jar 2>&1 | tee -a "$LOGFILE"
