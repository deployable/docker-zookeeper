FROM openjdk:8-jre-alpine

ARG ZK_MIRROR=http://apache.mirror.digitalpacific.com.au
ARG ZK_VERSION=3.4.9
ARG ZK_SHA1=0285717bf5ea87a7a36936bf37851d214a32bb99
ARG ZK_BASE=/zookeeper

RUN set -uex; \
    ZK_label="zookeeper-$ZK_VERSION"; \
    ZK_file="${ZK_label}.tar.gz"; \
    apk add --no-cache bash curl; \
    curl $ZK_MIRROR/zookeeper/$ZK_label/$ZK_file > /tmp/$ZK_file; \
    shasum=$(sha1sum /tmp/$ZK_file | awk '{print $1}'); \
    [ "$shasum" == "$ZK_SHA1" ] || exit 1; \
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
      version=$ZK_VERSION

EXPOSE 2181 2888 3888
WORKDIR /zookeeper
VOLUME ["/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/zookeeper/bin/zkServer.sh", "start-foreground"]
