#!/bin/bash

(./run-prometheus.sh > /dev/null 2>&1 || echo "prometheus terminated") &
(./run-grafana.sh > /dev/null 2>&1 || echo "grafana terminated") &
(./run-hello-world-app.sh > /dev/null 2>&1 || echo "hello world app terminated") &

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

echo 'HTTP Ports:'
echo '  * 3000: Grafana (log in with admin/admin)'
echo '  * 8080: hello world app'
echo '  * 9090: Prometheus'

sleep infinity
