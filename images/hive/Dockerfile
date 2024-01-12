# 构建阶段
ARG TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}
FROM --platform=${TARGETPLATFORM} ubuntu:focal AS builder

# optionally default hadoop version:
ARG HIVE_VERSION=3.1.3
ARG PG_LIB_VERSION=42.4.0
RUN apt-get update && apt-get install -y curl

#Install Hive and PostgreSQL JDBC
RUN apt-get update && apt-get install -y procps && \
	curl -kfSLO https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz -o /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz \
	&& tar -xzvf /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz -C /opt \
    && rm -rf /tmp/hadoop-${HADOOP_VERSION}.tar.gz \
	&& mv /opt/apache-hive-${HIVE_VERSION}-bin /opt/hive \
    && curl -kfSL https://jdbc.postgresql.org/download/postgresql-$PG_LIB_VERSION.jar -o /opt/hive/lib/postgresql-jdbc.jar \
    && find /opt/hive/ -type f \( -name "*.bat" -o -name "*.dll" -o -name "*.exe" -o -name "*.cmd" -o -name "*-tests.jar" -o -name "*-sources.jar" \) -delete


# 运行阶段
ARG HADOOP_BASE_IMAGE
ARG TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}
FROM --platform=${TARGETPLATFORM} ${HADOOP_BASE_IMAGE}

MAINTAINER itzhang89 <itzhang89@163.com>

ARG HIVE_VERSION=3.1.3
ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH

# replace the low version guava jar on hive
RUN rm -rf $HIVE_HOME/lib/guava-19.0.jar \
    && cp $HADOOP_HOME/share/hadoop/common/lib/guava-27.0-jre.jar $HIVE_HOME/lib/ \
    && rm -rf $HIVE_HOME/lib/postgresql-9.4.1208.jre7.jar

# create hive user and group
RUN useradd -r -m -U -s /bin/bash --groups hadoop hive

#Custom configuration goes here
COPY --chown=hive:hadoop conf/* $HIVE_HOME/conf/
COPY --chown=hive:hadoop startup.sh /usr/local/bin/
COPY --chown=hive:hadoop startup-metastore.sh /usr/local/bin/
COPY --chown=hive:hadoop entrypoint.sh /usr/local/bin/

EXPOSE 10000 10002

ENTRYPOINT ["entrypoint.sh"]
CMD startup.sh
