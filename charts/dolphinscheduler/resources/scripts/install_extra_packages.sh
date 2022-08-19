#!/usr/bin/env bash

# install spark
SPARK_VERSION=3.2.1
cd /tmp &&
  curl -fSLO https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-without-hadoop.tgz &&
  tar -xvzf /tmp/spark-${SPARK_VERSION}-bin-without-hadoop.tgz -C /opt/soft &&
  ln -s /opt/soft/spark-${SPARK_VERSION}-bin-without-hadoop /opt/soft/spark &&
  rm -rf spark-${SPARK_VERSION}-bin-without-hadoop.tgz

# install hadoop
HADOOP_VERSION=3.2.3
cd /tmp &&
  curl -fSLO https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz &&
  tar -xvzf /tmp/hadoop-$HADOOP_VERSION.tar.gz -C /opt/soft --exclude=hadoop-$HADOOP_VERSION/share/doc --exclude=hadoop-$HADOOP_VERSION/share/doc --exclude='*.cmd' &&
  ln -s /opt/soft/hadoop-$HADOOP_VERSION /opt/soft/hadoop &&
  rm -rf hadoop-$HADOOP_VERSION.tar.gz

#${SPARK_HOME2}/bin/spark-submit --master yarn --deploy-mode cluster --class org.apache.spark.examples.SparkPi --driver-cores 1 --driver-memory 512M --num-executors 2 --executor-cores 2 --executor-memory 2G --queue default spark-examples_2.12-3.2.1.jar

# setup the spark on yarn configuration. reference https://www.cnblogs.com/luengmingbiao/p/12985143.html
cd /opt/soft/spark && cp ./conf/spark-env.sh.template ./conf/spark-env.sh

sed -i '$a\export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop' conf/spark-env.sh
sed -i '$a\export YARN_CONF_DIR=${HADOOP_HOME}/etc/hadoop' conf/spark-env.sh

# 配置保证资源调度按照CPU + 内存模式
sed -i 's|DefaultResourceCalculator|DominantResourceCalculator|g' /opt/soft/hadoop/etc/hadoop/capacity-scheduler.xml

sed -i '$d' /opt/soft/hadoop/etc/hadoop/yarn-site.xml

sed -i '$a\    <property>' /opt/soft/hadoop/etc/hadoop/yarn-site.xml
sed -i '$a\      <description>Whether to enable log aggregation</description>' /opt/soft/hadoop/etc/hadoop/yarn-site.xml
sed -i '$a\      <name>yarn.log-aggregation-enable</name>' /opt/soft/hadoop/etc/hadoop/yarn-site.xml
sed -i '$a\      <value>true</value>' /opt/soft/hadoop/etc/hadoop/yarn-site.xml
sed -i '$a\    </property>' /opt/soft/hadoop/etc/hadoop/yarn-site.xml

sed -i '$a\    <property>' /opt/soft/hadoop/etc/hadoop/yarn-site.xml
sed -i '$a\      <name>yarn.log.server.url</name>' /opt/soft/hadoop/etc/hadoop/yarn-site.xml
sed -i '$a\      <value>http://my-platform-hadoop-historyserver-hl:19888/jobhistory/logs</value>' /opt/soft/hadoop/etc/hadoop/yarn-site.xml
sed -i '$a\    </property>' /opt/soft/hadoop/etc/hadoop/yarn-site.xml

sed -i '$a\</configuration>' /opt/soft/hadoop/etc/hadoop/yarn-site.xml

# 修改mapred-site.xml
sed -i '$d' /opt/soft/hadoop/etc/hadoop/mapred-site.xml

sed -i '$a\    <property>' /opt/soft/hadoop/etc/hadoop/mapred-site.xml
sed -i '$a\      <name>mapreduce.jobhistory.address</name>' /opt/soft/hadoop/etc/hadoop/mapred-site.xml
sed -i '$a\      <value>my-platform-hadoop-historyserver-hl:10020</value>' /opt/soft/hadoop/etc/hadoop/mapred-site.xml
sed -i '$a\    </property>' /opt/soft/hadoop/etc/hadoop/mapred-site.xml

sed -i '$a\    <property>' /opt/soft/hadoop/etc/hadoop/mapred-site.xml
sed -i '$a\      <name>mapreduce.jobhistory.webapp.address</name>' /opt/soft/hadoop/etc/hadoop/mapred-site.xml
sed -i '$a\      <value>my-platform-hadoop-historyserver-hl:19888</value>' /opt/soft/hadoop/etc/hadoop/mapred-site.xml
sed -i '$a\    </property>' /opt/soft/hadoop/etc/hadoop/mapred-site.xml

sed -i '$a\</configuration>' /opt/soft/hadoop/etc/hadoop/mapred-site.xml

# 修改 etc/hadoop/core-site.xml
sed -i '$d' /opt/soft/hadoop/etc/hadoop/core-site.xml

sed -i '$a\    <property>' /opt/soft/hadoop/etc/hadoop/core-site.xml
sed -i '$a\      <name>fs.defaultFS</name>' /opt/soft/hadoop/etc/hadoop/core-site.xml
sed -i '$a\      <value>hdfs://my-platform-hadoop-namenode:9820</value>' /opt/soft/hadoop/etc/hadoop/core-site.xml
sed -i '$a\    </property>' /opt/soft/hadoop/etc/hadoop/core-site.xml

sed -i '$a\</configuration>' /opt/soft/hadoop/etc/hadoop/core-site.xml

# 修改spakr-defaults.conf文件：
cd /opt/soft/spark && cp ./conf/spark-defaults.conf.template ./conf/spark-defaults.conf

sed -i '$a\spark.eventLog.dir=hdfs:///user/spark/applicationHistory' /opt/soft/spark/conf/spark-defaults.conf
sed -i '$a\spark.eventLog.enabled=true' /opt/soft/spark/conf/spark-defaults.conf
sed -i '$a\spark.yarn.historyServer.address=http://my-platform-spark-master-svc:18080' /opt/soft/spark/conf/spark-defaults.conf

# start the spark history server
./sbin/start-history-server.sh
