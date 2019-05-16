FROM maven:3.3.3-jdk-8 as builder
LABEL image=skywalking-build
ARG RELEASE_VERSION=v6.0.0-alpha
ENV TAG_NAME=$RELEASE_VERSION
ENV SKYWALKING_BUILD_HOME=/usr/local/skywalking
RUN git clone https://github.com/apache/incubator-skywalking.git $SKYWALKING_BUILD_HOME
WORKDIR $SKYWALKING_BUILD_HOME/
RUN git checkout $TAG_NAME
RUN git submodule init
RUN git submodule update
RUN set -ex; \
    ./mvnw clean package -DskipTests


FROM openjdk:8-jre-alpine
LABEL image=skywalking-collector
MAINTAINER Andrey Kozichev <akozichev@gmail.com>
ENV JAVA_OPTS="-Xms256M -Xmx512M"
ENV DIST_NAME=apache-skywalking-apm-incubating
ENV SKYWALKING_BUILD_HOME=/usr/local/skywalking
ENV SKYWALKING_HOME /opt/skywalking/
COPY --from=builder $SKYWALKING_BUILD_HOME/dist/$DIST_NAME.tar.gz $SKYWALKING_HOME
WORKDIR $SKYWALKING_HOME/
RUN set -ex; \
    tar -xzf "$DIST_NAME.tar.gz"; \
    rm -rf "$DIST_NAME.tar.gz"; rm -rf "$DIST_NAME/config/log4j2.xml"; \
    rm -rf "$DIST_NAME/bin"; rm -rf "$DIST_NAME/webapp"; rm -rf "$DIST_NAME/agent";
RUN GRPC_HEALTH_PROBE_VERSION=v0.2.1 && \
    wget -qO$SKYWALKING_HOME/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
    chmod +x $SKYWALKING_HOME/grpc_health_probe
ENV APP_HOME $SKYWALKING_HOME/apache-skywalking-apm-incubating
WORKDIR $APP_HOME
COPY files/log4j2.xml $APP_HOME/config/
COPY files/docker-entrypoint.sh $APP_HOME/
ENTRYPOINT ["sh", "docker-entrypoint.sh"]



FROM openjdk:8-jre-alpine
LABEL image=skywalking-ui
MAINTAINER Andrey Kozichev <akozichev@gmail.com>
ENV JAVA_OPTS="-Xms256M -Xmx512M"
ENV DIST_NAME=apache-skywalking-apm-incubating
ENV SKYWALKING_BUILD_HOME=/usr/local/skywalking
ENV SKYWALKING_HOME /opt/skywalking/
COPY --from=builder $SKYWALKING_BUILD_HOME/dist/$DIST_NAME.tar.gz $SKYWALKING_HOME
WORKDIR $SKYWALKING_HOME/
RUN set -ex; \
    tar -xzf "$DIST_NAME.tar.gz"; \
    rm -rf "$DIST_NAME.tar.gz"; rm -rf "$DIST_NAME/config"; \
    rm -rf "$DIST_NAME/bin"; rm -rf "$DIST_NAME/oap-server"; rm -rf "$DIST_NAME/agent";
ENV APP_HOME $SKYWALKING_HOME/apache-skywalking-apm-incubating
WORKDIR $APP_HOME
COPY ui_files/docker-entrypoint.sh .
COPY ui_files/logback.xml webapp/
ENTRYPOINT ["sh", "docker-entrypoint.sh"]





