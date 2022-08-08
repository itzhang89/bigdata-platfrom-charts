FROM bitnami/spark:3.2.1-debian-11-r3

MAINTAINER itzhang89 <itzhang89@163.com>

# Allow buildtime config of LIVY_VERSION
ARG LIVY_VERSION
# Set LIVY_VERSION from arg if provided at build, env if provided at run, or default
# https://docs.docker.com/engine/reference/builder/#using-arg-variables
# https://docs.docker.com/engine/reference/builder/#environment-replacement
ENV LIVY_VERSION=${LIVY_VERSION:-0.7.1}
ENV LIVY_HOME /opt/livy
ENV PATH $LIVY_HOME/bin:$PATH

USER root
#Install livy
RUN apt-get update && apt-get install -y wget procps unzip && cd /tmp && \
	wget https://archive.apache.org/dist/incubator/livy/${LIVY_VERSION}-incubating/apache-livy-${LIVY_VERSION}-incubating-bin.zip && \
    unzip /tmp/apache-livy-${LIVY_VERSION}-incubating-bin.zip -d /opt && \
	ln -s /opt/apache-livy-${LIVY_VERSION}-incubating-bin $LIVY_HOME && \
	rm -rf apache-livy-${LIVY_VERSION}-incubating-bin.zip && \
	apt-get --purge remove -y wget unzip && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

EXPOSE 8998
WORKDIR ${LIVY_HOME}

CMD ${LIVY_HOME}/bin/livy-server start
