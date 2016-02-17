# https://registry.hub.docker.com/u/phusion/baseimage/
FROM phusion/baseimage:latest
MAINTAINER launchbadge <contact@launchbadge.com>

# Install base system requirements
RUN apt-get update && \
    apt-get install -q -y \
      git libtcnative-1 \
      curl \
      software-properties-common \
      python-software-properties

# Install Java 8
RUN apt-add-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install oracle-java8-installer -y

# Timezone
ENV TZ                 America/Los_Angeles

# Use the default unprivileged account. This could be considered bad practice
# on systems where multiple processes end up being executed by 'daemon' but
# here we only ever run one process anyway.
ENV RUN_USER            root
ENV RUN_GROUP           root

# Java tuning
ENV JAVA_OPTS           -Xmx1024m

# Bamboo
ENV BAMBOO_VERSION      5.10.1.1
ENV BAMBOO_TARBALL_URL  https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-$BAMBOO_VERSION.tar.gz
ENV BAMBOO_INSTALL_DIR  /srv
ENV BAMBOO_HOME         /data

# Download and extract bamboo server
RUN curl -L $BAMBOO_TARBALL_URL | tar xz --strip=1 -C $BAMBOO_INSTALL_DIR

VOLUME ["${BAMBOO_HOME}"]

# HTTP Port
EXPOSE 8085

# Agent Port
EXPOSE 54663

# Run in foreground
WORKDIR $BAMBOO_INSTALL_DIR
# CMD ["./bin/start-bitbucket.sh", "-fg"]
