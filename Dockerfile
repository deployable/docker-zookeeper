FROM openjdk:8-jre-alpine

ARG ZK_MIRROR=http://mirror.cogentco.com/pub/apache
ARG ZK_VERSION=3.4.9
ENV ZK_VERSION $ZK_VERSION
ARG ZK_SHA1=0285717bf5ea87a7a36936bf37851d214a32bb99
ARG ZK_BASE=/zookeeper
ARG ZK_DATA=/tmp/zookeeper
ENV ZK_DATA $ZK_DATA

RUN set -uex; \
    ZK_label="zookeeper-$ZK_VERSION"; \
    ZK_file="${ZK_label}.tar.gz"; \
    apk add --no-cache bash curl; \
    curl $ZK_MIRROR/zookeeper/$ZK_label/$ZK_file > /tmp/$ZK_file; \
    shasum=$(sha1sum /tmp/$ZK_file | awk '{print $1}'); \
    [ -n "$shasum" ] && [ "$shasum" == "$ZK_SHA1" ] || exit 1; \
    tar -C /tmp -xvzf /tmp/$ZK_file; \
    rm /tmp/$ZK_file; \
    mv /tmp/$ZK_label /zookeeper; \
    rm -rf /zookeeper/src /zookeeper/docs; \
    find /zookeeper/contrib/ -name src -exec rm -rf {} +; \
    cp /zookeeper/conf/zoo_sample.cfg /zookeeper/conf/zoo.cfg; \
    mkdir -p /zookeeper/var;

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

LABEL name="deployable/zookeeper" \
      maintainer="Matt Hoyle" \
      version=3.4.9-2
       
VOLUME ["/zookeeper/conf", "/tmp/zookeeper"]

WORKDIR /zookeeper
EXPOSE 2181 2888 3888
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/zookeeper/bin/zkServer.sh", "start-foreground"]

