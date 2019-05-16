FROM openjdk:8-jre-alpine
LABEL image=skywalking-collector
MAINTAINER Andrey Kozichev <akozichev@gmail.com>
ARG DOWNLOAD_LINK="http://www.mirrorservice.org/sites/ftp.apache.org/skywalking/6.1.0/apache-skywalking-apm-6.1.0.tar.gz"
ENV JAVA_OPTS="-Xms256M -Xmx512M"
ENV DIST_NAME=apache-skywalking-apm-bin
ENV SKYWALKING_BUILD_HOME=/usr/local/skywalking
ENV SKYWALKING_HOME /opt/skywalking/
RUN mkdir -p $SKYWALKING_HOME
RUN wget -qO $SKYWALKING_HOME/$DIST_NAME.tar.gz $DOWNLOAD_LINK 
WORKDIR $SKYWALKING_HOME/
RUN set -ex; \
    tar -xzf "$DIST_NAME.tar.gz"; \
    rm -rf "$DIST_NAME.tar.gz"; rm -rf "$DIST_NAME/config/log4j2.xml"; \
    rm -rf "$DIST_NAME/bin"; rm -rf "$DIST_NAME/webapp"; rm -rf "$DIST_NAME/agent";
RUN GRPC_HEALTH_PROBE_VERSION=v0.2.1 && \
    wget -qO$SKYWALKING_HOME/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
    chmod +x $SKYWALKING_HOME/grpc_health_probe
ENV APP_HOME $SKYWALKING_HOME/apache-skywalking-apm-bin
WORKDIR $APP_HOME
COPY files/log4j2.xml $APP_HOME/config/
COPY files/docker-entrypoint.sh $APP_HOME/
ENTRYPOINT ["sh", "docker-entrypoint.sh"]



FROM openjdk:8-jre-alpine
LABEL image=skywalking-ui
MAINTAINER Andrey Kozichev <akozichev@gmail.com>
ENV JAVA_OPTS="-Xms256M -Xmx512M"
ENV DIST_NAME=apache-skywalking-apm-bin
ENV SKYWALKING_BUILD_HOME=/usr/local/skywalking
ENV SKYWALKING_HOME /opt/skywalking/
ARG DOWNLOAD_LINK="http://www.mirrorservice.org/sites/ftp.apache.org/skywalking/6.1.0/apache-skywalking-apm-6.1.0.tar.gz"
RUN mkdir -p $SKYWALKING_HOME
RUN wget -qO $SKYWALKING_HOME/$DIST_NAME.tar.gz $DOWNLOAD_LINK 
WORKDIR $SKYWALKING_HOME/
RUN set -ex; \
    tar -xzf "$DIST_NAME.tar.gz"; \
    rm -rf "$DIST_NAME.tar.gz"; rm -rf "$DIST_NAME/config"; \
    rm -rf "$DIST_NAME/bin"; rm -rf "$DIST_NAME/oap-server"; rm -rf "$DIST_NAME/agent";
ENV APP_HOME $SKYWALKING_HOME/apache-skywalking-apm-bin
WORKDIR $APP_HOME
COPY ui_files/docker-entrypoint.sh .
COPY ui_files/logback.xml webapp/
ENTRYPOINT ["sh", "docker-entrypoint.sh"]





