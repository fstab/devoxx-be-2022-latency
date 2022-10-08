FROM openjdk:11.0.15-slim

WORKDIR /app
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl unzip
COPY . .
RUN mkdir downloads
RUN mkdir bin
RUN ./install-grafana.sh
RUN ./install-prometheus.sh
RUN ./mvnw package

FROM openjdk:8-jre-slim
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl unzip vim procps
WORKDIR /app
COPY --from=0 /app/bin ./bin/
COPY --from=0 /app/hello-world-app/ ./hello-world-app/
COPY --from=0 /app/load-test-10/ ./load-test-10/
COPY --from=0 /app/load-test-400/ ./load-test-400/
COPY --from=0 /app/load-test-final/ ./load-test-final/
COPY run-*.sh ./
COPY grafana-*.yaml ./
COPY prometheus.yml ./
COPY latency.json ./
RUN mkdir logs
# 3000 -> Grafana
EXPOSE 3000
# 8080 -> hello world app
EXPOSE 8080
# 9090 -> Prometheus
EXPOSE 9090
CMD ./run-all.sh & /bin/bash
