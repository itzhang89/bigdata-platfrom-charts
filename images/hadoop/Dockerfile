# 构建阶段
ARG HADOOP_BASE_IMAGE
ARG TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}
FROM --platform=${TARGETPLATFORM} ${HADOOP_BASE_IMAGE}

ENV MULTIHOMED_NETWORK 1
# create hdfs, yarn, hadoop group and create hdfs and yarn user
RUN useradd -r -m -U -s /bin/bash --groups hadoop hdfs \
    && useradd -r -m -U -s /bin/bash --groups hadoop yarn \
    && useradd -r -m -U -s /bin/bash --groups hadoop mapred \
    && useradd -r -m -U -s /bin/bash httpfs \
    && useradd -r -m -U -s /bin/bash kms

COPY --chown=hadoop:hadoop entrypoint.sh /entrypoint.sh
# Default port for NameNode / ResourceManager / MapReduce JobHistory Server
EXPOSE 9870 8088 19888
ENTRYPOINT ["/entrypoint.sh"]
