#!/bin/bash

if [[ $1 == "hiveserver" ]]; then
  hadoop fs -mkdir /tmp
  hadoop fs -mkdir -p /user/hive/warehouse
  hadoop fs -chmod g+w /tmp
  hadoop fs -chmod g+w /user/hive/warehouse

  $HIVE_HOME/bin/hiveserver2 --hiveconf hive.server2.enable.doAs=false
fi

if [[ $1 == "metastore" ]]; then
  # init the metastore database on the first time
  $HIVE_HOME/bin/schematool -dbType postgres -validate || $HIVE_HOME/bin/schematool -dbType postgres -initSchema

  # start the metastore server
  $HIVE_HOME/bin/hive --service metastore
fi

# ------------------------------------------------------
# Start bash if requested (parameter -bash)
# ------------------------------------------------------
if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
