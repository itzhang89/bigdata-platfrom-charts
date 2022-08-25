FROM openjdk:8-slim-buster

MAINTAINER itzhang89 <itzhang89@163.com>

ENV HADOOP_VERSION=${HADOOP_VERSION:-3.2.3}
ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
ENV HADOOP_HOME /opt/hadoop
ENV PATH $HADOOP_HOME/bin/:$PATH
ENV MULTIHOMED_NETWORK 1
ENV HADOOP_CONF_DIR /etc/hadoop

USER root

# install extra packages
RUN softwares='curl netcat gnupg procps' \
    && apt-get update && apt-get install -y $softwares --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# install hadoop
RUN curl https://dist.apache.org/repos/dist/release/hadoop/common/KEYS | gpg --import \
    && set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ --exclude=hadoop-$HADOOP_VERSION/share/doc --exclude=hadoop-$HADOOP_VERSION/share/doc --exclude='*.cmd'\
    && ln -s /opt/hadoop-$HADOOP_VERSION $HADOOP_HOME \
    && ln -s $HADOOP_HOME/etc/hadoop /etc/hadoop \
    && rm /tmp/hadoop.tar.gz*

# create hdfs, yarn, hadoop group and create hdfs and yarn user
RUN groupadd -g 999 -r hadoop \
    && groupadd -g 991 -r hdfs \
    && groupadd -g 995 -r yarn \
    && useradd --comment "HDFS User" -u 992 --shell /bin/bash -M -r -N --groups hadoop,hdfs --home /var/lib/hadoop/hdfs hdfs \
    && useradd --comment "Yarn User" -u 996 --shell /bin/bash -M -r -N --groups hadoop,yarn --home /var/lib/hadoop/yarn yarn

ADD entrypoint.sh /entrypoint.sh

# Default port for NameNode / ResourceManager / MapReduce JobHistory Server
EXPOSE 9870 8088 19888

WORKDIR $HADOOP_HOME

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]