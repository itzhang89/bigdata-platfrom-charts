# dolphinscheduler

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/dolphinscheduler)](https://artifacthub.io/packages/helm/bigdata-charts/dolphinscheduler) ![Version: 2.0.0](https://img.shields.io/badge/Version-2.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.0.0](https://img.shields.io/badge/AppVersion-3.0.0-informational?style=flat-square)

Dolphin Scheduler is a distributed and easy-to-expand visual DAG workflow scheduling system, dedicated to solving the complex dependencies in data processing, making the scheduling system out of the box for data processing.

## Installing the Chart

To install the chart with the release name `my-dolphinscheduler`:

```console
$ helm repo add itzhang89 https://itzhang89.github.io/bigdata-platfrom-charts
$ helm upgrade --install my-dolphinscheduler itzhang89/dolphinscheduler --version 2.0.0
```
To uninstall the release

```console
$ helm delete my-dolphinscheduler
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | postgresql | ~11.6.0 |
| https://charts.bitnami.com/bitnami | zookeeper | ~10.0.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| alert.affinity | object | `{}` |  |
| alert.annotations | object | `{}` |  |
| alert.env.JAVA_OPTS | string | `"-Xms512m -Xmx512m -Xmn256m"` |  |
| alert.livenessProbe.enabled | bool | `true` |  |
| alert.livenessProbe.failureThreshold | string | `"3"` |  |
| alert.livenessProbe.initialDelaySeconds | string | `"30"` |  |
| alert.livenessProbe.periodSeconds | string | `"30"` |  |
| alert.livenessProbe.successThreshold | string | `"1"` |  |
| alert.livenessProbe.timeoutSeconds | string | `"5"` |  |
| alert.nodeSelector | object | `{}` |  |
| alert.persistentVolumeClaim.accessModes[0] | string | `"ReadWriteOnce"` |  |
| alert.persistentVolumeClaim.enabled | bool | `false` |  |
| alert.persistentVolumeClaim.storage | string | `"20Gi"` |  |
| alert.persistentVolumeClaim.storageClassName | string | `"-"` |  |
| alert.readinessProbe.enabled | bool | `true` |  |
| alert.readinessProbe.failureThreshold | string | `"3"` |  |
| alert.readinessProbe.initialDelaySeconds | string | `"30"` |  |
| alert.readinessProbe.periodSeconds | string | `"30"` |  |
| alert.readinessProbe.successThreshold | string | `"1"` |  |
| alert.readinessProbe.timeoutSeconds | string | `"5"` |  |
| alert.replicas | int | `1` |  |
| alert.resources | object | `{}` |  |
| alert.strategy.rollingUpdate.maxSurge | string | `"25%"` |  |
| alert.strategy.rollingUpdate.maxUnavailable | string | `"25%"` |  |
| alert.strategy.type | string | `"RollingUpdate"` |  |
| alert.tolerations | list | `[]` |  |
| api.affinity | object | `{}` |  |
| api.annotations | object | `{}` |  |
| api.env.JAVA_OPTS | string | `"-Xms512m -Xmx512m -Xmn256m"` |  |
| api.livenessProbe.enabled | bool | `true` |  |
| api.livenessProbe.failureThreshold | string | `"3"` |  |
| api.livenessProbe.initialDelaySeconds | string | `"30"` |  |
| api.livenessProbe.periodSeconds | string | `"30"` |  |
| api.livenessProbe.successThreshold | string | `"1"` |  |
| api.livenessProbe.timeoutSeconds | string | `"5"` |  |
| api.nodeSelector | object | `{}` |  |
| api.persistentVolumeClaim.accessModes[0] | string | `"ReadWriteOnce"` |  |
| api.persistentVolumeClaim.enabled | bool | `false` |  |
| api.persistentVolumeClaim.storage | string | `"20Gi"` |  |
| api.persistentVolumeClaim.storageClassName | string | `"-"` |  |
| api.readinessProbe.enabled | bool | `true` |  |
| api.readinessProbe.failureThreshold | string | `"3"` |  |
| api.readinessProbe.initialDelaySeconds | string | `"30"` |  |
| api.readinessProbe.periodSeconds | string | `"30"` |  |
| api.readinessProbe.successThreshold | string | `"1"` |  |
| api.readinessProbe.timeoutSeconds | string | `"5"` |  |
| api.replicas | string | `"1"` |  |
| api.resources | object | `{}` |  |
| api.service.annotations | object | `{}` |  |
| api.service.clusterIP | string | `""` |  |
| api.service.externalIPs | list | `[]` |  |
| api.service.externalName | string | `""` |  |
| api.service.loadBalancerIP | string | `""` |  |
| api.service.nodePort | string | `""` |  |
| api.service.type | string | `"ClusterIP"` |  |
| api.strategy.rollingUpdate.maxSurge | string | `"25%"` |  |
| api.strategy.rollingUpdate.maxUnavailable | string | `"25%"` |  |
| api.strategy.type | string | `"RollingUpdate"` |  |
| api.tolerations | list | `[]` |  |
| common.configmap.DATASOURCE_ENCRYPTION_ENABLE | string | `"false"` |  |
| common.configmap.DATASOURCE_ENCRYPTION_SALT | string | `"!@#$%^&*"` |  |
| common.configmap.DATAX_HOME | string | `"/opt/soft/datax"` |  |
| common.configmap.DATA_BASEDIR_PATH | string | `"/tmp/dolphinscheduler"` |  |
| common.configmap.DOLPHINSCHEDULER_OPTS | string | `""` |  |
| common.configmap.FLINK_HOME | string | `"/opt/soft/flink"` |  |
| common.configmap.FS_DEFAULT_FS | string | `"file:///"` |  |
| common.configmap.FS_S3A_ACCESS_KEY | string | `"xxxxxxx"` |  |
| common.configmap.FS_S3A_ENDPOINT | string | `"s3.xxx.amazonaws.com"` |  |
| common.configmap.FS_S3A_SECRET_KEY | string | `"xxxxxxx"` |  |
| common.configmap.HADOOP_CONF_DIR | string | `"/opt/soft/hadoop/etc/hadoop"` |  |
| common.configmap.HADOOP_HOME | string | `"/opt/soft/hadoop"` |  |
| common.configmap.HADOOP_SECURITY_AUTHENTICATION_STARTUP_STATE | string | `"false"` |  |
| common.configmap.HDFS_ROOT_USER | string | `"hdfs"` |  |
| common.configmap.HIVE_HOME | string | `"/opt/soft/hive"` |  |
| common.configmap.JAVA_HOME | string | `"/usr/local/openjdk-8"` |  |
| common.configmap.JAVA_SECURITY_KRB5_CONF_PATH | string | `"/opt/krb5.conf"` |  |
| common.configmap.KERBEROS_EXPIRE_TIME | string | `"2"` |  |
| common.configmap.LOGIN_USER_KEYTAB_PATH | string | `"/opt/hdfs.keytab"` |  |
| common.configmap.LOGIN_USER_KEYTAB_USERNAME | string | `"hdfs@HADOOP.COM"` |  |
| common.configmap.PYTHON_HOME | string | `"/usr/bin/python"` |  |
| common.configmap.RESOURCE_MANAGER_HTTPADDRESS_PORT | string | `"8088"` |  |
| common.configmap.RESOURCE_STORAGE_TYPE | string | `"HDFS"` |  |
| common.configmap.RESOURCE_UPLOAD_PATH | string | `"/dolphinscheduler"` |  |
| common.configmap.SPARK_HOME1 | string | `"/opt/soft/spark1"` |  |
| common.configmap.SPARK_HOME2 | string | `"/opt/soft/spark2"` |  |
| common.configmap.SUDO_ENABLE | string | `"true"` |  |
| common.configmap.YARN_APPLICATION_STATUS_ADDRESS | string | `"http://ds1:%s/ws/v1/cluster/apps/%s"` |  |
| common.configmap.YARN_JOB_HISTORY_STATUS_ADDRESS | string | `"http://ds1:19888/ws/v1/history/mapreduce/jobs/%s"` |  |
| common.configmap.YARN_RESOURCEMANAGER_HA_RM_IDS | string | `""` |  |
| common.fsFileResourcePersistence.accessModes[0] | string | `"ReadWriteMany"` |  |
| common.fsFileResourcePersistence.enabled | bool | `false` |  |
| common.fsFileResourcePersistence.storage | string | `"20Gi"` |  |
| common.fsFileResourcePersistence.storageClassName | string | `"-"` |  |
| common.sharedStoragePersistence.accessModes[0] | string | `"ReadWriteMany"` |  |
| common.sharedStoragePersistence.enabled | bool | `false` |  |
| common.sharedStoragePersistence.mountPath | string | `"/opt/soft"` |  |
| common.sharedStoragePersistence.storage | string | `"20Gi"` |  |
| common.sharedStoragePersistence.storageClassName | string | `"-"` |  |
| conf.common."alert.rpc.port" | int | `50052` |  |
| conf.common."aws.access.key.id" | string | `"minioadmin"` |  |
| conf.common."aws.endpoint" | string | `"http://localhost:9000"` |  |
| conf.common."aws.region" | string | `"us-east-1"` |  |
| conf.common."aws.secret.access.key" | string | `"minioadmin"` |  |
| conf.common."data-quality.jar.name" | string | `"dolphinscheduler-data-quality-dev-SNAPSHOT.jar"` |  |
| conf.common."data.basedir.path" | string | `"/tmp/dolphinscheduler"` |  |
| conf.common."datasource.encryption.enable" | bool | `false` |  |
| conf.common."datasource.encryption.salt" | string | `"!@#$%^&*"` |  |
| conf.common."development.state" | bool | `false` |  |
| conf.common."fs.defaultFS" | string | `"file:///"` |  |
| conf.common."hadoop.security.authentication.startup.state" | bool | `false` |  |
| conf.common."hdfs.root.user" | string | `"hdfs"` |  |
| conf.common."java.security.krb5.conf.path" | string | `"/opt/krb5.conf"` |  |
| conf.common."kerberos.expire.time" | int | `2` |  |
| conf.common."login.user.keytab.path" | string | `"/opt/hdfs.headless.keytab"` |  |
| conf.common."login.user.keytab.username" | string | `"hdfs-mycluster@ESZ.COM"` |  |
| conf.common."resource.manager.httpaddress.port" | int | `8088` |  |
| conf.common."resource.storage.type" | string | `"HDFS"` |  |
| conf.common."resource.upload.path" | string | `"/dolphinscheduler"` |  |
| conf.common."sudo.enable" | bool | `true` |  |
| conf.common."support.hive.oneSession" | bool | `false` |  |
| conf.common."yarn.application.status.address" | string | `"http://ds1:%s/ws/v1/cluster/apps/%s"` |  |
| conf.common."yarn.job.history.status.address" | string | `"http://ds1:19888/ws/v1/history/mapreduce/jobs/%s"` |  |
| conf.common."yarn.resourcemanager.ha.rm.ids" | string | `"192.168.xx.xx,192.168.xx.xx"` |  |
| conf.common."zeppelin.rest.url" | string | `"http://localhost:8080"` |  |
| externalDatabase.database | string | `"dolphinscheduler"` |  |
| externalDatabase.host | string | `"localhost"` |  |
| externalDatabase.params | string | `"characterEncoding=utf8"` |  |
| externalDatabase.password | string | `"Dolphinscheduler@2022"` |  |
| externalDatabase.port | string | `"5432"` |  |
| externalDatabase.type | string | `"postgresql"` |  |
| externalDatabase.username | string | `"dolphinscheduler"` |  |
| externalRegistry.registryPluginDir | string | `"lib/plugin/registry"` |  |
| externalRegistry.registryPluginName | string | `"zookeeper"` |  |
| externalRegistry.registryServers | string | `"127.0.0.1:2181"` |  |
| global.postgresql.auth.database | string | `"dolphinscheduler"` |  |
| global.postgresql.auth.password | string | `"Dolphinscheduler@2022"` |  |
| global.postgresql.auth.postgresPassword | string | `"postgres"` |  |
| global.postgresql.auth.username | string | `"dolphinscheduler"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.pullSecret | string | `""` |  |
| image.registry | string | `"dolphinscheduler.docker.scarf.sh/apache"` |  |
| image.tag | string | `"3.0.0"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.host | string | `"dolphinscheduler.org"` |  |
| ingress.path | string | `"/dolphinscheduler"` |  |
| ingress.tls.enabled | bool | `false` |  |
| ingress.tls.secretName | string | `"dolphinscheduler-tls"` |  |
| master.affinity | object | `{}` |  |
| master.annotations | object | `{}` |  |
| master.env.JAVA_OPTS | string | `"-Xms1g -Xmx1g -Xmn512m"` |  |
| master.env.MASTER_DISPATCH_TASK_NUM | string | `"3"` |  |
| master.env.MASTER_EXEC_TASK_NUM | string | `"20"` |  |
| master.env.MASTER_EXEC_THREADS | string | `"100"` |  |
| master.env.MASTER_FAILOVER_INTERVAL | string | `"10m"` |  |
| master.env.MASTER_HEARTBEAT_ERROR_THRESHOLD | string | `"5"` |  |
| master.env.MASTER_HEARTBEAT_INTERVAL | string | `"10s"` |  |
| master.env.MASTER_HOST_SELECTOR | string | `"LowerWeight"` |  |
| master.env.MASTER_KILL_YARN_JOB_WHEN_HANDLE_FAILOVER | string | `"true"` |  |
| master.env.MASTER_MAX_CPU_LOAD_AVG | string | `"-1"` |  |
| master.env.MASTER_RESERVED_MEMORY | string | `"0.3"` |  |
| master.env.MASTER_STATE_WHEEL_INTERVAL | string | `"5s"` |  |
| master.env.MASTER_TASK_COMMIT_INTERVAL | string | `"1s"` |  |
| master.env.MASTER_TASK_COMMIT_RETRYTIMES | string | `"5"` |  |
| master.livenessProbe.enabled | bool | `true` |  |
| master.livenessProbe.failureThreshold | string | `"3"` |  |
| master.livenessProbe.initialDelaySeconds | string | `"30"` |  |
| master.livenessProbe.periodSeconds | string | `"30"` |  |
| master.livenessProbe.successThreshold | string | `"1"` |  |
| master.livenessProbe.timeoutSeconds | string | `"5"` |  |
| master.nodeSelector | object | `{}` |  |
| master.persistentVolumeClaim.accessModes[0] | string | `"ReadWriteOnce"` |  |
| master.persistentVolumeClaim.enabled | bool | `false` |  |
| master.persistentVolumeClaim.storage | string | `"20Gi"` |  |
| master.persistentVolumeClaim.storageClassName | string | `"-"` |  |
| master.podManagementPolicy | string | `"Parallel"` |  |
| master.readinessProbe.enabled | bool | `true` |  |
| master.readinessProbe.failureThreshold | string | `"3"` |  |
| master.readinessProbe.initialDelaySeconds | string | `"30"` |  |
| master.readinessProbe.periodSeconds | string | `"30"` |  |
| master.readinessProbe.successThreshold | string | `"1"` |  |
| master.readinessProbe.timeoutSeconds | string | `"5"` |  |
| master.replicas | string | `"3"` |  |
| master.resources | object | `{}` |  |
| master.tolerations | list | `[]` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.primary.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| postgresql.primary.persistence.enabled | bool | `true` |  |
| timezone | string | `"Asia/Shanghai"` |  |
| worker.affinity | object | `{}` |  |
| worker.annotations | object | `{}` |  |
| worker.env.WORKER_EXEC_THREADS | string | `"100"` |  |
| worker.env.WORKER_GROUPS | string | `"default"` |  |
| worker.env.WORKER_GROUPS_0 | string | `"default"` |  |
| worker.env.WORKER_HEARTBEAT_INTERVAL | string | `"10s"` |  |
| worker.env.WORKER_HEART_ERROR_THRESHOLD | string | `"5"` |  |
| worker.env.WORKER_HOST_WEIGHT | string | `"100"` |  |
| worker.env.WORKER_MAX_CPU_LOAD_AVG | string | `"-1"` |  |
| worker.env.WORKER_RESERVED_MEMORY | string | `"0.3"` |  |
| worker.livenessProbe.enabled | bool | `true` |  |
| worker.livenessProbe.failureThreshold | string | `"3"` |  |
| worker.livenessProbe.initialDelaySeconds | string | `"30"` |  |
| worker.livenessProbe.periodSeconds | string | `"30"` |  |
| worker.livenessProbe.successThreshold | string | `"1"` |  |
| worker.livenessProbe.timeoutSeconds | string | `"5"` |  |
| worker.nodeSelector | object | `{}` |  |
| worker.persistentVolumeClaim.dataPersistentVolume.accessModes[0] | string | `"ReadWriteOnce"` |  |
| worker.persistentVolumeClaim.dataPersistentVolume.enabled | bool | `false` |  |
| worker.persistentVolumeClaim.dataPersistentVolume.storage | string | `"20Gi"` |  |
| worker.persistentVolumeClaim.dataPersistentVolume.storageClassName | string | `"-"` |  |
| worker.persistentVolumeClaim.enabled | bool | `false` |  |
| worker.persistentVolumeClaim.logsPersistentVolume.accessModes[0] | string | `"ReadWriteOnce"` |  |
| worker.persistentVolumeClaim.logsPersistentVolume.enabled | bool | `false` |  |
| worker.persistentVolumeClaim.logsPersistentVolume.storage | string | `"20Gi"` |  |
| worker.persistentVolumeClaim.logsPersistentVolume.storageClassName | string | `"-"` |  |
| worker.podManagementPolicy | string | `"Parallel"` |  |
| worker.readinessProbe.enabled | bool | `true` |  |
| worker.readinessProbe.failureThreshold | string | `"3"` |  |
| worker.readinessProbe.initialDelaySeconds | string | `"30"` |  |
| worker.readinessProbe.periodSeconds | string | `"30"` |  |
| worker.readinessProbe.successThreshold | string | `"1"` |  |
| worker.readinessProbe.timeoutSeconds | string | `"5"` |  |
| worker.replicas | string | `"3"` |  |
| worker.resources | object | `{}` |  |
| worker.tolerations | list | `[]` |  |
| zookeeper.enabled | bool | `true` |  |
| zookeeper.fourlwCommandsWhitelist | string | `"srvr,ruok,wchs,cons"` |  |
| zookeeper.persistence.enabled | bool | `false` |  |
| zookeeper.persistence.size | string | `"20Gi"` |  |
| zookeeper.persistence.storageClass | string | `"-"` |  |
| zookeeper.service.port | int | `2181` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)