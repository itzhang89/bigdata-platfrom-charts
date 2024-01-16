ARG HIVE_BASE_IMAGE
ARG TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}
FROM --platform=${TARGETPLATFORM} ${HIVE_BASE_IMAGE}

#Custom configuration goes here
COPY --chown=hive:hadoop conf/* $HIVE_HOME/conf/
COPY --chown=hive:hadoop entrypoint.sh /entrypoint.sh
COPY --chown=hive:hadoop bootstrap.sh /usr/local/bin/

# persist the env to /etc/environment
RUN echo "HIVE_HOME=/opt/hive" >> /etc/environment \
    && echo "HIVE_CONF_DIR=/etc/hive" >> /etc/environment \
    && sed -i "s|PATH=.*|PATH=\"$PATH\"|" /etc/environment

EXPOSE 10000 10002

WORKDIR /opt/hive

ENTRYPOINT ["/entrypoint.sh"]
CMD bootstrap.sh
