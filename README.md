# platform

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/bigdata-charts)](https://artifacthub.io/packages/helm/bigdata-charts/platform)

A Bigdata Platform Helm chart for Kubernetes

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add yutianaiqingtian https://yutianaiqingtian.github.io/bigdata-platfrom-charts
$ helm upgrade --install my-release yutianaiqingtian/platform
```
To uninstall the release

```console
$ helm delete my-release
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
|  | dolphinscheduler | ~2.0.0 |
|  | hadoop | ~1.0.1 |
|  | hive | ~0.1.8 |
|  | hue | ~1.0.3 |
|  | openldap | ~2.0.4 |
| https://airflow-helm.github.io/charts | airflow | ~8.6.0 |
| https://apache.github.io/superset | superset | ~0.6.3 |
| https://charts.bitnami.com/bitnami | common | ~1.16.0 |
| https://charts.bitnami.com/bitnami | postgresql-interval(postgresql) | ~11.6.0 |
| https://charts.bitnami.com/bitnami | redis | ~16.3.1 |
| https://charts.bitnami.com/bitnami | spark | ~6.1.5 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| airflow.airflow.image.pullPolicy | string | `"IfNotPresent"` |  |
| airflow.airflow.image.repository | string | `"5200710/airflow"` |  |
| airflow.airflow.image.tag | string | `"2.3.0"` |  |
| airflow.airflow.webserverSecretKey | string | `"8e74ab588296bd461aff914a7af2755d"` |  |
| airflow.dags.gitSync.branch | string | `"v2-2-stable"` |  |
| airflow.dags.gitSync.enabled | bool | `true` |  |
| airflow.dags.gitSync.repo | string | `"https://github.com/apache/airflow.git"` |  |
| airflow.dags.gitSync.repoSubPath | string | `"tests/dags"` |  |
| airflow.enabled | bool | `true` |  |
| airflow.externalDatabase.host | string | `"my-platform-postgresql-interval"` |  |
| airflow.externalDatabase.password | string | `"Airflow@2022"` |  |
| airflow.externalRedis.host | string | `"my-platform-redis-master"` |  |
| airflow.externalRedis.port | int | `6379` |  |
| airflow.ingress.enabled | bool | `true` |  |
| airflow.ingress.flower.host | string | `"flower.demo.com"` |  |
| airflow.ingress.web.host | string | `"airflow.demo.com"` |  |
| airflow.postgresql.enabled | bool | `false` |  |
| airflow.redis.enabled | bool | `false` |  |
| airflow.web.webserverConfig.stringOverride | string | `"from flask_appbuilder.security.manager import AUTH_LDAP\n\nAUTH_TYPE = AUTH_LDAP\nAUTH_LDAP_SERVER = \"ldap://my-platform-openldap:389\"\nAUTH_LDAP_USE_TLS = False\n\n# registration configs\nAUTH_USER_REGISTRATION = True  # allow users who are not already in the FAB DB\nAUTH_USER_REGISTRATION_ROLE = \"Admin\"  # this role will be given in addition to any AUTH_ROLES_MAPPING\nAUTH_LDAP_FIRSTNAME_FIELD = \"givenName\"\nAUTH_LDAP_LASTNAME_FIELD = \"sn\"\nAUTH_LDAP_EMAIL_FIELD = \"mail\"  # if null in LDAP, email is set to: \"{username}@email.notfound\"\n\n# search configs\nAUTH_LDAP_SEARCH = \"ou=databu,dc=demo,dc=com\"  # the LDAP search base\nAUTH_LDAP_UID_FIELD = \"uid\"  # the username field\nAUTH_LDAP_BIND_USER = \"cn=admin,dc=demo,dc=com\"  # the special bind username for search\nAUTH_LDAP_BIND_PASSWORD = \"Root@2022\"  # the special bind password for search\n\n# a mapping from LDAP DN to a list of FAB roles\nAUTH_ROLES_MAPPING = {\n    \"cn=zhy,ou=databu,dc=demo,dc=com\": [\"User\"],\n    \"cn=zjh,ou=databu,dc=demo,dc=com\": [\"Admin\"],\n}\n\n# the LDAP user attribute which has their role DNs\nAUTH_LDAP_GROUP_FIELD = \"memberOf\"\n\n# if we should replace ALL the user's roles each login, or only on registration\nAUTH_ROLES_SYNC_AT_LOGIN = True\n\n# force users to re-auth after 30min of inactivity (to keep roles in sync)\nPERMANENT_SESSION_LIFETIME = 1800\n"` |  |
| dolphinscheduler.common.configmap.FS_DEFAULT_FS | string | `"hdfs://my-platform-hadoop-namenode:9820"` |  |
| dolphinscheduler.common.configmap.RESOURCE_STORAGE_TYPE | string | `"HDFS"` |  |
| dolphinscheduler.common.sharedStoragePersistence.enabled | bool | `true` |  |
| dolphinscheduler.common.sharedStoragePersistence.storageClassName | string | `"rook-cephfs"` |  |
| dolphinscheduler.conf.common."fs.defaultFS" | string | `"hdfs://my-platform-hadoop-namenode:9820"` |  |
| dolphinscheduler.conf.common."resource.storage.type" | string | `"HDFS"` |  |
| dolphinscheduler.enabled | bool | `true` |  |
| dolphinscheduler.externalDatabase.database | string | `"dolphinscheduler"` |  |
| dolphinscheduler.externalDatabase.host | string | `"my-platform-postgresql-interval"` |  |
| dolphinscheduler.externalDatabase.params | string | `"characterEncoding=utf8"` |  |
| dolphinscheduler.externalDatabase.password | string | `"Dolphinscheduler@2022"` |  |
| dolphinscheduler.externalDatabase.port | string | `"5432"` |  |
| dolphinscheduler.externalDatabase.type | string | `"postgresql"` |  |
| dolphinscheduler.externalDatabase.username | string | `"dolphinscheduler"` |  |
| dolphinscheduler.ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"2048m"` |  |
| dolphinscheduler.ingress.enabled | bool | `true` |  |
| dolphinscheduler.ingress.host | string | `"dolphinscheduler.demo.com"` |  |
| dolphinscheduler.ingress.path | string | `"/"` |  |
| dolphinscheduler.postgresql.enabled | bool | `false` |  |
| hadoop.conf.coreSite."hadoop.proxyuser.hive.groups" | string | `"*"` |  |
| hadoop.conf.coreSite."hadoop.proxyuser.hive.hosts" | string | `"*"` |  |
| hadoop.conf.coreSite."hadoop.proxyuser.httpfs.groups" | string | `"*"` |  |
| hadoop.conf.coreSite."hadoop.proxyuser.httpfs.hosts" | string | `"*"` |  |
| hadoop.conf.coreSite."hadoop.proxyuser.hue.groups" | string | `"*"` |  |
| hadoop.conf.coreSite."hadoop.proxyuser.hue.hosts" | string | `"*"` |  |
| hadoop.conf.hdfsSite."dfs.permissions.enabled" | bool | `false` |  |
| hadoop.conf.hdfsSite."dfs.replication" | int | `3` |  |
| hadoop.conf.hdfsSite."dfs.webhdfs.enable" | bool | `true` |  |
| hadoop.conf.httpfsSite."httpfs.proxyuser.hue.groups" | string | `"*"` |  |
| hadoop.conf.httpfsSite."httpfs.proxyuser.hue.hosts" | string | `"*"` |  |
| hadoop.enabled | bool | `true` |  |
| hadoop.ingress.nameNode.enabled | bool | `true` |  |
| hadoop.ingress.nameNode.hosts[0] | string | `"hdfs.demo.com"` |  |
| hadoop.ingress.resourcemanager.enabled | bool | `true` |  |
| hadoop.ingress.resourcemanager.hosts[0] | string | `"resourcemanager.demo.com"` |  |
| hadoop.persistence.dataNode.enabled | bool | `true` |  |
| hadoop.persistence.nameNode.enabled | bool | `true` |  |
| hive.conf.hadoopConfigMap | string | `"my-platform-hadoop-hadoop"` |  |
| hive.conf.hiveSite."hive.metastore.schema.verification" | bool | `false` |  |
| hive.conf.hiveSite."hive.metastore.warehouse.dir" | string | `"hdfs://my-platform-hadoop-namenode:9820/user/hive/warehouse"` |  |
| hive.enabled | bool | `true` |  |
| hive.hive-metastore.enabled | bool | `true` |  |
| hive.hive-metastore.postgresql.auth.database | string | `"metastore"` |  |
| hive.hive-metastore.postgresql.auth.password | string | `"Hive@2022"` |  |
| hive.hive-metastore.postgresql.auth.username | string | `"hive"` |  |
| hive.hive-metastore.postgresql.enabled | bool | `false` |  |
| hive.hive-metastore.postgresql.host | string | `"{{ template \"platform.postgresql-interval\" . }}"` |  |
| hive.hive-metastore.postgresql.port | int | `5432` |  |
| hue.enabled | bool | `true` |  |
| hue.hue.interpreters | string | `"[[[postgresql]]]\nname = postgresql\ninterface=sqlalchemy\noptions='{\"url\": \"postgresql://training:Training@2022@my-platform-postgresql-interval:5432/training\"}'"` |  |
| hue.hue.replicas | int | `1` |  |
| hue.hue.zz_hue_ini | string | `"[desktop]\nsecret_key=hue123\n# ref: https://gethue.com/mini-how-to-disabling-some-apps-from-showing-up/\napp_blacklist=spark,zookeeper,hbase,impala,search,pig,sqoop,security,oozie,jobsub,jobbrowser\ndjango_debug_mode=false\ngunicorn_work_class=sync\nenable_prometheus=true\n\n[[task_server]]\nenabled=false\nbroker_url=redis://redis:6379/0\nresult_cache='{\"BACKEND\": \"django_redis.cache.RedisCache\", \"LOCATION\": \"redis://redis:6379/0\", \"OPTIONS\": {\"CLIENT_CLASS\": \"django_redis.client.DefaultClient\"},\"KEY_PREFIX\": \"queries\"}'\ncelery_result_backend=redis://redis:6379/0\n\n[[custom]]\n[[auth]]\nbackend=desktop.auth.backend.LdapBackend,desktop.auth.backend.AllowFirstUserDjangoBackend\n\n[[ldap]]\nldap_url=ldap://{{ template \"platform.openldap\" . }}:389\nsearch_bind_authentication=true\nuse_start_tls=false\ncreate_users_on_login=true\nbase_dn=\"ou=databu,dc=demo,dc=com\"\nbind_dn=\"cn=admin,dc=demo,dc=com\"\nbind_password=Root@2022\ntest_ldap_user=\"cn=admin,dc=demo,dc=com\"\ntest_ldap_group=\"cn=openldap,dc=demo,dc=com\"\n\n[[[users]]]\nuser_filter=\"objectClass=posixAccount\"\nuser_name_attr=\"uid\"\n\n[[[groups]]]\ngroup_filter=\"objectClass=posixGroup\"\ngroup_name_attr=\"cn\"\ngroup_member_attr=\"memberUid\"\n\n[beeswax]\n# Host where HiveServer2 is running.\nhive_server_host=my-platform-hive-hiveserver\n# Port where HiveServer2 Thrift server runs on.\nhive_server_port=10000\nthrift_version=7\n\n[notebook]\n[[interpreters]]\n[[[hive]]]\nname=Hive\ninterface=hiveserver2\n\n[hadoop]\n[[hdfs_clusters]]\n[[[default]]]\nfs_defaultfs=hdfs://{{ template \"platform.hadoop\" . }}:9820\nwebhdfs_url=http://{{ template \"platform.hadoop\" . }}-httpfs:14000/webhdfs/v1\n\n# Configuration for YARN (MR2)\n# ------------------------------------------------------------------------\n[[yarn_clusters]]\n[[[default]]]\nresourcemanager_host={{ template \"platform.hadoop\" . }}-resourcemanager-hl\nresourcemanager_api_url=http://{{ template \"platform.hadoop\" . }}-resourcemanager-hl:8088/\nresourcemanager_port=8032\nhistory_server_api_url=http://{{ template \"platform.hadoop\" . }}-historyserver-hl:19888/\nspark_history_server_url=http://{{ template \"platform.hadoop\" . }}-spark-master-svc:18080\n"` |  |
| hue.ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"2048m"` |  |
| hue.ingress.enabled | bool | `true` |  |
| hue.ingress.hosts[0] | string | `"hue.demo.com"` |  |
| hue.postgresql.auth.password | string | `"Hue@2022"` |  |
| hue.postgresql.enabled | bool | `false` |  |
| hue.postgresql.host | string | `"{{ template \"platform.postgresql-interval\" . }}"` |  |
| openldap.adminPassword | string | `"Root@2022"` |  |
| openldap.configPassword | string | `"Root@2022"` |  |
| openldap.customLdifFiles."01-default-users.ldif" | string | `"# Entry 2: ou=databu,dc=demo,dc=com\ndn: ou=databu,dc=demo,dc=com\nobjectclass: organizationalUnit\nobjectclass: top\nou: databu\n\n# Entry 3: cn=yhj,ou=databu,dc=demo,dc=com\ndn: cn=yhj,ou=databu,dc=demo,dc=com\ncn: yhj\ngidnumber: 500\ngivenname: y\nhomedirectory: /home/users/yhj\nloginshell: /bin/bash\nobjectclass: inetOrgPerson\nobjectclass: posixAccount\nobjectclass: top\nsn: hj\nuid: yhj\nuidnumber: 1001\nuserpassword: {MD5}lOjN5GErP9OQZ31C57IgAg==\n\n# Entry 4: cn=zhy,ou=databu,dc=demo,dc=com\ndn: cn=zhy,ou=databu,dc=demo,dc=com\ncn: zhy\ngidnumber: 500\ngivenname: z\nhomedirectory: /home/users/zhy\nloginshell: /bin/bash\nobjectclass: inetOrgPerson\nobjectclass: posixAccount\nobjectclass: top\nsn: hy\nuid: zhy\nuidnumber: 1007\nuserpassword: {MD5}lOjN5GErP9OQZ31C57IgAg==\n\n# Entry 5: cn=zjh,ou=databu,dc=demo,dc=com\ndn: cn=zjh,ou=databu,dc=demo,dc=com\ncn: zjh\nemployeetype: Admin\ngidnumber: 500\ngivenname: z\nhomedirectory: /home/users/zjh\nloginshell: /bin/bash\nobjectclass: inetOrgPerson\nobjectclass: posixAccount\nobjectclass: top\nsn: jh\nuid: zjh\nuidnumber: 1000\nuserpassword: {MD5}lOjN5GErP9OQZ31C57IgAg=="` |  |
| openldap.enabled | bool | `true` |  |
| openldap.env.LDAP_DOMAIN | string | `"demo.com"` |  |
| openldap.env.LDAP_ORGANISATION | string | `"Training Inc."` |  |
| openldap.env.LDAP_TLS | string | `"false"` |  |
| openldap.env.LDAP_TLS_VERIFY_CLIENT | string | `"nerver"` |  |
| openldap.phpldapadmin.ingress.enabled | bool | `true` |  |
| openldap.phpldapadmin.ingress.hostname | string | `"phpldapadmin.demo.com"` |  |
| postgresql-interval.auth.database | string | `"training"` |  |
| postgresql-interval.auth.password | string | `"Training@2022"` |  |
| postgresql-interval.auth.postgresPassword | string | `"Root@2022"` |  |
| postgresql-interval.auth.username | string | `"training"` |  |
| postgresql-interval.enabled | bool | `true` |  |
| postgresql-interval.primary.initdb.password | string | `"Root@2022"` |  |
| postgresql-interval.primary.initdb.scripts."db_init.sql" | string | `"CREATE DATABASE airflow;\nCREATE ROLE airflow WITH ENCRYPTED PASSWORD 'Airflow@2022' LOGIN;\nGRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;\n\nCREATE DATABASE dolphinscheduler;\nCREATE ROLE dolphinscheduler WITH ENCRYPTED PASSWORD 'Dolphinscheduler@2022' LOGIN;\nGRANT ALL PRIVILEGES ON DATABASE dolphinscheduler TO dolphinscheduler;\n\nCREATE DATABASE metastore;\nCREATE ROLE hive WITH ENCRYPTED PASSWORD 'Hive@2022' LOGIN;\nGRANT ALL PRIVILEGES ON DATABASE metastore TO hive;\n\nCREATE DATABASE hue;\nCREATE ROLE hue WITH ENCRYPTED PASSWORD 'Hue@2022' LOGIN;\nGRANT ALL PRIVILEGES ON DATABASE hue TO hue;\n\nCREATE DATABASE superset;\nCREATE ROLE superset WITH ENCRYPTED PASSWORD 'Superset@2022' LOGIN;\nGRANT ALL PRIVILEGES ON DATABASE superset TO superset;\n\nflush privileges;\n"` |  |
| postgresql-interval.primary.initdb.user | string | `"postgres"` |  |
| redis.architecture | string | `"standalone"` |  |
| redis.auth.enabled | bool | `false` |  |
| redis.enabled | bool | `true` |  |
| serviceAccount.create> | bool | `false` |  |
| spark.enabled | bool | `true` |  |
| spark.ingress.enabled | bool | `true` |  |
| spark.ingress.hostname | string | `"spark.demo.com"` |  |
| superset.bootstrapScript | string | `"#!/bin/bash\napt-get update -y && apt-get install -y libsasl2-dev python-dev libldap2-dev libssl-dev &&     rm -rf /var/lib/apt/lists/* &&     pip install       psycopg2-binary==2.9.1       python-ldap==3.4.0       PyHive==0.6.5       mysqlclient==2.1.1       redis==3.5.3 &&     if [ ! -f ~/bootstrap ]; then echo \"Running Superset with uid {{ .Values.runAsUser }}\" > ~/bootstrap; fi\n"` |  |
| superset.configOverrides.enable_oauth | string | `"# 引入AUTH_LDAP\nfrom flask_appbuilder.security.manager import AUTH_DB,AUTH_LDAP\n\n# 修改LDAP配置\nAUTH_TYPE = AUTH_LDAP\n\n# Uncomment to setup Full admin role name\nAUTH_ROLE_ADMIN = 'admin'\n\n# 打开自注册配置\n# Will allow user self registration\nAUTH_USER_REGISTRATION = True\n\n# 打开此注释，并改为admin角色\n# The default user self registration role\nAUTH_USER_REGISTRATION_ROLE = \"admin\"\n\n# When using LDAP Auth, setup the ldap server\nAUTH_LDAP_SERVER = 'ldap://{{ template \"platform.openldap\" . }}:389'\nAUTH_LDAP_SEARCH = \"ou=databu,dc=demo,dc=com\"\nAUTH_LDAP_UID_FIELD = \"cn\"\n\n# 绑定某个初始账号，我这里用的app组织的账号，跟上面People不是同一个ou,无所谓，能登录就行，主要是不希望配置个人账号到应用里。\nAUTH_LDAP_BIND_USER = \"cn=admin,dc=demo,dc=com\"\nAUTH_LDAP_BIND_PASSWORD = \"Root@2022\"\n"` |  |
| superset.configOverrides.secret | string | `"SECRET_KEY = 'sOpgvM1hGAohEXS2fafKH3IS8gUAaKHU4mYFTr7h1FsM9gT2tp7N6v1S'\n"` |  |
| superset.enabled | bool | `true` |  |
| superset.ingress.enabled | bool | `true` |  |
| superset.ingress.hosts[0] | string | `"superset.demo.com"` |  |
| superset.init.adminUser.password | string | `"Root@2022"` |  |
| superset.postgresql.enabled | bool | `false` |  |
| superset.redis.enabled | bool | `false` |  |
| superset.supersetNode.connections.db_host | string | `"{{ template \"platform.postgresql-interval\" . }}"` |  |
| superset.supersetNode.connections.db_pass | string | `"Superset@2022"` |  |
| superset.supersetNode.connections.redis_host | string | `"my-platform-redis-headless"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)