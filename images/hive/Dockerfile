# 构建阶段
ARG HADOOP_BASE_IMAGE
ARG TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}
FROM --platform=${TARGETPLATFORM} ${HADOOP_BASE_IMAGE}
MAINTAINER itzhang89 <itzhang89@163.com>

# optionally default hadoop version:
ARG HIVE_VERSION=3.1.3
ARG PG_LIB_VERSION=42.7.0
ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH

# create hive user and group
RUN useradd -r -m -U -s /bin/bash --groups hadoop hive
#Install Hive and PostgreSQL JDBC
RUN curl -kfSL https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz -o /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz \
	&& tar -xzf /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz -C /opt && rm -rf /tmp/* \
	&& mv /opt/apache-hive-${HIVE_VERSION}-bin $HIVE_HOME \
    && find $HIVE_HOME/ -type f \( -name "*.bat" -o -name "*.dll" -o -name "*.exe" -o -name "*.cmd" -o -name "*-tests.jar" -o -name "*-sources.jar" \) -delete \
    && find $HIVE_HOME/lib -type f \( -name "postgresql-*.jre7.jar" -o -name "guava-*-jre.jar" \) -delete \
    && curl -kfSL https://jdbc.postgresql.org/download/postgresql-$PG_LIB_VERSION.jar -o $HIVE_HOME/lib/postgresql-jdbc.jar \
    && find $HADOOP_HOME/share/hadoop/common/lib -type f -name "guava-*-jre.jar" -exec cp {} $HIVE_HOME/lib/ \; \
    && chown hive:hadoop -R $HIVE_HOME

#Custom configuration goes here
COPY --chown=hive:hadoop conf/* $HIVE_HOME/conf/
COPY --chown=hive:hadoop entrypoint.sh /usr/local/bin/
COPY --chown=hive:hadoop bootstrap.sh /usr/local/bin/

# persist the env to /etc/environment
RUN echo "HIVE_HOME=/opt/hive" >> /etc/environment \
    && sed -i "s|PATH=.*|PATH=\"$PATH\"|" /etc/environment

EXPOSE 10000 10002

WORKDIR /opt/hive

ENTRYPOINT ["entrypoint.sh"]
CMD bootstrap.sh
