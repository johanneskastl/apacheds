FROM ubuntu:22.04

LABEL org.opencontainers.image.authors="Johannes Kastl <git@johannes-kastl.de>"
LABEL org.opencontainers.image.title="ApacheDS"
LABEL org.opencontainers.image.description="ApacheDS™ is an extensible and embeddable directory server entirely written in Java, which has been certified LDAPv3 compatible by the Open Group"
LABEL org.opencontainers.image.source="https://github.com/johanneskastl/containerimage_apacheds"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL io.k8s.description="ApacheDS"
LABEL io.k8s.display-name="ApacheDS"

ENV JDK_VERSION=1.8.0
ENV APACHEDS_VERSION=2.0.0.AM27
ENV ADS_HOME=/usr/local/apacheds
ENV ADS_INSTANCES=/var/apacheds
ENV ADS_INSTANCE_NAME=default

RUN apt-get update && \
    apt-get -y install openjdk-8-jdk-headless curl apt-transport-https gnupg netcat ldap-utils && \
    apt-get -y upgrade && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -r apacheds -g 433 && \
    useradd -u 431 -r -g apacheds -d /usr/local/apacheds -s /sbin/nologin -c "ApacheDS image user" apacheds && \
    mkdir /usr/local/apacheds && \
    chown -R apacheds:apacheds /usr/local/apacheds && \
    curl https://downloads.apache.org/directory/apacheds/dist/$APACHEDS_VERSION/apacheds-$APACHEDS_VERSION.tar.gz -o /usr/local/apacheds/apacheds.tar.gz && \
    cd /usr/local/apacheds && \
    tar -xvzf apacheds.tar.gz && \
    mv apacheds-2.0.0.AM28-SNAPSHOT/* . && \
    mv lib/apacheds-service-2.0.0.AM28-SNAPSHOT.jar lib/apacheds-service-$APACHEDS_VERSION-SNAPSHOT.jar && \
    rm -rf apacheds-2.0.0.AM28-SNAPSHOT && \
    mkdir /var/apacheds && \
    chown -R apacheds:apacheds /var/apacheds

ADD --chown=apacheds:apacheds run_apacheds.sh /usr/local/apacheds/bin/run_apacheds.sh
ADD --chown=apacheds:apacheds log4j.properties /usr/local/apacheds/conf/log4j.properties

USER 431

CMD ["/usr/local/apacheds/bin/run_apacheds.sh"]
