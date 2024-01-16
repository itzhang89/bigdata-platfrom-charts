# 构建阶段
ARG TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}
FROM --platform=${TARGETPLATFORM} ubuntu:focal AS builder

# optionally default hadoop version:
ARG HADOOP_VERSION=3.3.5
RUN apt-get update && apt-get install -y curl

RUN case ${TARGETARCH} in \
        "amd64")  HADOOP_ARCH="amd64"  ;; \
        "arm64")  HADOOP_ARCH="-aarch64"  ;; \
    esac && \
    curl -L -S https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}${HADOOP_ARCH}.tar.gz -o /tmp/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar xzf /tmp/hadoop-${HADOOP_VERSION}.tar.gz -C /opt/ \
    && rm -rf /tmp/hadoop-${HADOOP_VERSION}.tar.gz && \
    mv /opt/hadoop-${HADOOP_VERSION} /opt/hadoop && \
    rm -rf /opt/hadoop/share/doc && \
    rm -rf /opt/hadoop/share/hadoop/tools && \
    find /opt/hadoop/ -type f \( -name "*.bat" -o -name "*.dll" -o -name "*.exe" -o -name "*.cmd" -o -name "*-tests.jar" -o -name "*-sources.jar" \) -delete

# 运行阶段
FROM --platform=${TARGETPLATFORM} ubuntu:focal
MAINTAINER itzhang89 <itzhang89@163.com>

ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_CONF_DIR /etc/hadoop

# install extra packages
RUN softwares='iproute2 netcat gnupg procps openjdk-8-jdk curl' \
        && apt-get update && apt-get install --no-install-recommends -y $softwares \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /var/cache/apt/archives/*

# create a hadoop user and group
RUN useradd -r -m -U hadoop -s /bin/bash
COPY --from=builder --chown=hadoop:hadoop /opt/hadoop /opt/hadoop

RUN ln -s $HADOOP_HOME/etc/hadoop /etc/hadoop && \
    mkdir /var/log/hadoop && \
    chown hadoop:hadoop -R /var/log/hadoop

# persist the env to /etc/environment
RUN echo "JAVA_HOME=$(readlink -f /usr/bin/java | sed 's:jre/bin/java::')" >> /etc/environment \
    && echo "HADOOP_HOME=/opt/hadoop" >> /etc/environment \
    && echo "HADOOP_CONF_DIR=/etc/hadoop" >> /etc/environment \
    && echo "PATH=$HADOOP_HOME/bin:\$PATH" >> /etc/environment

WORKDIR $HADOOP_HOME