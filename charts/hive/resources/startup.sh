#!/bin/bash

set -x

# Note. This script set hive paths in hdfs with user hive and ensures hiveServer is runAsUser hive
HADOOP_USER_NAME={{ .Values.conf.hdfsAdminUser }} hdfs dfs -mkdir -p /tmp/hive
HADOOP_USER_NAME={{ .Values.conf.hdfsAdminUser }} hdfs dfs -chmod 777 /tmp/hive
HADOOP_USER_NAME={{ .Values.conf.hdfsAdminUser }} hdfs dfs -chmod g+w /tmp/hive

HADOOP_USER_NAME={{ .Values.conf.hdfsAdminUser }} hdfs dfs -mkdir -p /user/hive/warehouse
HADOOP_USER_NAME={{ .Values.conf.hdfsAdminUser }} hdfs dfs -chmod g+w /user/hive/warehouse
HADOOP_USER_NAME={{ .Values.conf.hdfsAdminUser }} hdfs dfs -chown hive:hive /user/hive/warehouse

su hive -c "$HIVE_HOME/bin/hiveserver2 --hiveconf hive.root.logger={{ .Values.conf.logLevel }},console"