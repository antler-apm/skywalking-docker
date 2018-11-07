FROM maven:3.3.3-jdk-8 as builder
LABEL image=skywalking-build
ARG RELEASE_VERSION=v5.0.0-GA
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
ENV APP_HOME $SKYWALKING_HOME/apache-skywalking-apm-incubating/
CMD /usr/bin/java $JAVA_OPTS -cp "$APP_HOME/collector-libs/*:$APP_HOME/config" org.apache.skywalking.apm.collector.boot.CollectorBootStartUp



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
    rm -rf "$DIST_NAME/bin"; rm -rf "$DIST_NAME/collector-libs"; rm -rf "$DIST_NAME/agent";
ENV APP_HOME $SKYWALKING_HOME/apache-skywalking-apm-incubating/
CMD /usr/bin/java $JAVA_OPTS -jar $APP_HOME/webapp/skywalking-webapp.jar --spring.config.location=$APP_HOME/webapp/config/webapp.yml




