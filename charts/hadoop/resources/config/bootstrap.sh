#!/bin/bash

: ${HADOOP_HOME:=/opt/hadoop}

. $HADOOP_HOME/etc/hadoop/hadoop-env.sh

# Directory to find config artifacts
CONFIG_DIR="/tmp/hadoop-config"

# Copy config files from volume mount
for f in slaves core-site.xml hdfs-site.xml mapred-site.xml yarn-site.xml httpfs-site.xml; do
    if [[ -e ${CONFIG_DIR}/$f ]]; then
      cp ${CONFIG_DIR}/$f $HADOOP_HOME/etc/hadoop/$f
    else
      echo "ERROR: Could not find $f in $CONFIG_DIR"
    exit 1
    fi
done

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
cd $HADOOP_HOME/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

if [[ $2 == "namenode" ]]; then
    mkdir -p /data/dfs/name && chown -R hdfs:hadoop /data/dfs && chmod g+s /data/dfs
    export HADOOP_LOG_DIR=/var/log/hadoop-hdfs
    mkdir -p $HADOOP_LOG_DIR && chown -R hdfs:hadoop $HADOOP_LOG_DIR && chmod g+s $HADOOP_LOG_DIR
    # format the namenode if not formated
    [[ ! -f /data/dfs/name/current/VERSION ]] && su hdfs -c "$HADOOP_HOME/bin/hdfs namenode -format -force -nonInteractive"
    su hdfs -c "$HADOOP_HOME/sbin/hadoop-daemon.sh start namenode"
fi

if [[ $2 == "datanode" ]]; then
    [[ ! -d  /data/dfs/data ]] && mkdir -p  /data/dfs/data && chown -R hdfs:hadoop /data/dfs && chmod g+s /data/dfs
    export HADOOP_LOG_DIR=/var/log/hadoop-hdfs
    mkdir -p $HADOOP_LOG_DIR && chown -R hdfs:hadoop $HADOOP_LOG_DIR && chmod g+s $HADOOP_LOG_DIR
    #  wait up to 30 seconds for namenode
    (while [[ $count -lt 15 && -z $(curl -sf http://{{ include "hadoop.fullname" . }}-namenode:9870) && -z $(curl -sf http://{{ include "hadoop.fullname" . }}-namenode:50070) ]]; do ((count=count+1)) ; echo "Waiting for {{ include "hadoop.fullname" . }}-namenode" ; sleep 2; done && [[ $count -lt 15 ]])
    [[ $? -ne 0 ]] && echo "Timeout waiting for hdfs namenode, exiting." && exit 1

    su hdfs -c "$HADOOP_HOME/sbin/hadoop-daemon.sh start datanode"
fi

# ------------------------------------------------------
# Start HttpFs as daemons
# ------------------------------------------------------
if [[ $2 == "httpfs" ]]; then
  groupadd -g 998 -r httpfs && useradd -u 999 --shell /bin/bash -M -r -N --groups httpfs --home /var/lib/hadoop/httpfs httpfs
  export HTTPFS_TEMP=/tmp
  export HADOOP_LOG_DIR=/var/log/hadoop-httpfs
  mkdir -p $HADOOP_LOG_DIR && chown -R httpfs:httpfs $HADOOP_LOG_DIR && chmod g+s $HADOOP_LOG_DIR
  #  wait up to 30 seconds for namenode
  (while [[ $count -lt 15 && -z $(curl -sf http://{{ include "hadoop.fullname" . }}-namenode:9870) && -z $(curl -sf http://{{ include "hadoop.fullname" . }}-namenode:50070) ]]; do ((count=count+1)) ; echo "Waiting for {{ include "hadoop.fullname" . }}-namenode" ; sleep 2; done && [[ $count -lt 15 ]])
  [[ $? -ne 0 ]] && echo "Timeout waiting for hdfs namenode, exiting." && exit 1

  su httpfs -c "$HADOOP_HOME/bin/hdfs --daemon start httpfs"
fi

# ------------------------------------------------------
# Start RESOURCE MANAGER and PROXY SERVER as daemons
# ------------------------------------------------------
if [[ $2 == "resourcemanager" ]]; then
  export HADOOP_LOG_DIR=/var/log/hadoop-yarn
  mkdir -p $HADOOP_LOG_DIR && chown -R yarn:hadoop $HADOOP_LOG_DIR && chmod g+s $HADOOP_LOG_DIR
  su yarn -c "$HADOOP_HOME/bin/yarn --loglevel {{ .Values.logLevel }} --daemon start resourcemanager"
  su yarn -c "$HADOOP_HOME/bin/yarn --loglevel {{ .Values.logLevel }} --daemon start proxyserver"
fi
# ------------------------------------------------------
# Start NODE MANAGER
# ------------------------------------------------------
if [[ $2 == "nodemanager" ]]; then
  mkdir -p /data/yarn && chown -R yarn:hadoop /data/yarn && chmod g+s /data/yarn
  export HADOOP_LOG_DIR=/var/log/hadoop-yarn
  mkdir -p $HADOOP_LOG_DIR && chown -R yarn:hadoop $HADOOP_LOG_DIR && chmod g+s $HADOOP_LOG_DIR
  # Wait with timeout for resourcemanager
  TMP_URL="http://{{ include "hadoop.fullname" . }}-resourcemanager-hl:8088/ws/v1/cluster/info"
  if timeout 5m bash -c "until curl -sf $TMP_URL; do echo Waiting for $TMP_URL; sleep 5; done"; then
    su yarn -c "$HADOOP_HOME/bin/yarn nodemanager --loglevel {{ .Values.logLevel }}"
  else
    echo "$0: Timeout waiting for $TMP_URL, exiting."
    exit 1
  fi
fi
# ------------------------------------------------------
# Start MapReduce JobHistory Server as daemons
# ------------------------------------------------------
if [[ $2 == "historyserver" ]]; then
  export HADOOP_LOG_DIR=${HADOOP_HOME}/logs
  if timeout 5m bash -c "until nc -vz {{ include "hadoop.fullname" . }}-namenode {{ .Values.nameNode.port }} -w2; do echo Waiting for namenode; sleep 5; done"; then
    $HADOOP_HOME/bin/mapred  --loglevel {{ .Values.logLevel }} --daemon start historyserver
  else
    echo "$0: Timeout waiting for namenode, exiting."
    exit 1
  fi
fi
# ------------------------------------------------------
# Tail logfiles for daemonized workloads (parameter -d)
# ------------------------------------------------------
if [[ $1 == "-d" ]]; then
    until find ${HADOOP_LOG_DIR} -mmin -1 | egrep -q '.*'; echo "`date`: Waiting for logs..." ; do sleep 2 ; done
    tail -F ${HADOOP_LOG_DIR}/* &
    while true; do sleep 1000; done
fi

# ------------------------------------------------------
# Start bash if requested (parameter -bash)
# ------------------------------------------------------
if [[ $1 == "-bash" ]]; then
    /bin/bash
fi