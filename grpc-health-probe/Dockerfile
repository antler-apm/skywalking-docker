ARG RELEASE_VERSION=6.0.0-beta
FROM apache/skywalking-oap-server:$RELEASE_VERSION
LABEL image=oap
RUN GRPC_HEALTH_PROBE_VERSION=v0.2.1 && \
    wget -qO/skywalking/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
    chmod +x /skywalking/grpc_health_probe
