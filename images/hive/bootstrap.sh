#!/bin/bash

: ${HIVE_HOME:=/opt/hive}

function update_hive_env() {
  local env_file="$HIVE_HOME/conf/hive-env.sh"
  local env_name="$1"
  local env_value="$2"

  if [[ $(grep "^# export $env_name=" "$env_file" | wc -l) -eq 1 ]]; then
    # If there is a comment, uncomment line with a new environment variable
    sed -i "s|^# export $env_name=.*|export $env_name=\"$env_value\"|" "$env_file"
    echo "Updated $env_name in $env_file"
  else
    # append the new to end of the file
    echo "export $env_name=\"$env_value\"" >>"$env_file"
    echo "Added $env_name to $env_file"
  fi
}

# setup the java home if not special
[[ -z "$JAVA_HOME" ]] && JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:jre/bin/java::")
# replace the java_home in the hadoop-env file
update_hive_env JAVA_HOME $JAVA_HOME

if [[ $1 == "hiveserver" ]]; then
  su hdfs -c "$HADOOP_HOME/bin/hdfs dfs -mkdir /tmp"
  su hdfs -c "$HADOOP_HOME/bin/hdfs dfs -mkdir -p /user/hive/warehouse"
  su hdfs -c "$HADOOP_HOME/bin/hdfs dfs -chmod g+w /tmp"
  su hdfs -c "$HADOOP_HOME/bin/hdfs dfs -chmod g+w /user/hive/warehouse"

  $HIVE_HOME/bin/hiveserver2 --hiveconf hive.server2.enable.doAs=false
fi

if [[ $1 == "metastore" ]]; then
  # init the metastore database on the first time
  su hive -c "$HIVE_HOME/bin/schematool -dbType postgres -validate || $HIVE_HOME/bin/schematool -dbType postgres -initSchema"

  # start the metastore server
  su hive -c "$HIVE_HOME/bin/hive --service metastore"
fi

# ------------------------------------------------------
# Start bash if requested (parameter -bash)
# ------------------------------------------------------
if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
