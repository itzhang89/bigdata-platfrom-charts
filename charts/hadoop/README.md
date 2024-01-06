# hadoop

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/hadoop)](https://artifacthub.io/packages/helm/bigdata-charts/hadoop) ![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![AppVersion: 3.2.3](https://img.shields.io/badge/AppVersion-3.2.3-informational?style=flat-square)

The Apache Hadoop software library is a framework that allows for the distributed processing of large data sets across clusters of computers using simple programming models.

## Installing the Chart

To install the chart with the release name `my-hadoop`:

```console
$ helm repo add itzhang89 https://itzhang89.github.io/bigdata-platfrom-charts
$ helm upgrade --install my-hadoop itzhang89/hadoop --version 1.0.1
```
To uninstall the release

```console
$ helm delete my-hadoop
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| antiAffinity | string | `"soft"` |  |
| conf.coreSite | string | `nil` | conf.coreSite this configuration will take effect in the core-site.xml file |
| conf.hdfsSite | object | `{"dfs.replication":3}` | conf.hdfsSite this configuration will take effect in the hdfs-site.xml file |
| conf.httpfsSite | object | `{}` | conf.httpfsSite this configuration will take effect in the httpfs-site.xml file |
| conf.mapredSite | object | `{}` | conf.mapredSite this configuration will take effect in the mapred-site.xml file |
| conf.yarnSite | object | `{}` | conf.yarnSite this configuration will take effect in the yarn-site.xml file |
| dataNode.httpPort | int | `9864` |  |
| dataNode.httpsPort | int | `9865` |  |
| dataNode.pdbMinAvailable | int | `3` | ensure to set this value before deploying |
| dataNode.port | int | `9867` |  |
| dataNode.replicas | int | `3` | ensure this value is higher or equal to 'conf.hdfsSite.dfs.replication' |
| dataNode.resources.limits.cpu | string | `"1000m"` |  |
| dataNode.resources.limits.memory | string | `"2048Mi"` |  |
| dataNode.resources.requests.cpu | string | `"10m"` |  |
| dataNode.resources.requests.memory | string | `"256Mi"` |  |
| historyserver.enabled | bool | `true` |  |
| historyserver.pdbMinAvailable | int | `1` |  |
| historyserver.port | int | `19888` | historyserver container port. Default HTTP port is 19888. |
| historyserver.replicas | int | `1` |  |
| historyserver.service.annotations | object | `{}` |  |
| historyserver.service.loadBalancerIP | string | `nil` |  |
| historyserver.service.port | int | `80` |  |
| historyserver.service.type | string | `"ClusterIP"` |  |
| httpfs.adminPort | int | `14001` |  |
| httpfs.port | int | `14000` |  |
| image.pullPolicy | string | `"IfNotPresent"` | hadoop Docker image pullPolicy |
| image.repository | string | `"5200710/hadoop"` | hadoop Docker image repository. eg. [Docker Hub| Hadoop ](https://hub.docker.com/repository/docker/5200710/hadoop) |
| image.tag | string | `"3.2.3-java8"` | hadoop Docker image tag |
| ingress.dataNode.annotations | object | `{}` |  |
| ingress.dataNode.enabled | bool | `false` |  |
| ingress.dataNode.hosts[0] | string | `"hdfs-datanode.local"` |  |
| ingress.dataNode.labels | object | `{}` |  |
| ingress.dataNode.path | string | `"/"` |  |
| ingress.historyserver.annotations | object | `{}` |  |
| ingress.historyserver.enabled | bool | `false` |  |
| ingress.historyserver.hosts[0] | string | `"historyserver.local"` |  |
| ingress.historyserver.path | string | `"/"` |  |
| ingress.historyserver.pathType | string | `"ImplementationSpecific"` |  |
| ingress.historyserver.tls | list | `[]` |  |
| ingress.httpfs.annotations | object | `{}` |  |
| ingress.httpfs.enabled | bool | `false` |  |
| ingress.httpfs.hosts[0] | string | `"httpfs.local"` |  |
| ingress.httpfs.labels | object | `{}` |  |
| ingress.httpfs.path | string | `"/"` |  |
| ingress.nameNode.annotations | object | `{}` |  |
| ingress.nameNode.enabled | bool | `false` |  |
| ingress.nameNode.hosts[0] | string | `"hdfs-namenode.local"` |  |
| ingress.nameNode.labels | object | `{}` |  |
| ingress.nameNode.path | string | `"/"` |  |
| ingress.nameNode.pathType | string | `"ImplementationSpecific"` |  |
| ingress.nameNode.tls | list | `[]` |  |
| ingress.resourcemanager.annotations | object | `{}` |  |
| ingress.resourcemanager.enabled | bool | `false` |  |
| ingress.resourcemanager.hosts[0] | string | `"yarn.local"` |  |
| ingress.resourcemanager.path | string | `"/"` |  |
| ingress.resourcemanager.pathType | string | `"ImplementationSpecific"` |  |
| ingress.resourcemanager.tls | list | `[]` |  |
| logLevel | string | `"INFO"` |  |
| nameNode.httpPort | int | `9870` |  |
| nameNode.httpsPort | int | `9871` |  |
| nameNode.pdbMinAvailable | int | `1` |  |
| nameNode.port | int | `9820` |  |
| nameNode.resources.limits.cpu | string | `"1000m"` |  |
| nameNode.resources.limits.memory | string | `"2048Mi"` |  |
| nameNode.resources.requests.cpu | string | `"10m"` |  |
| nameNode.resources.requests.memory | string | `"256Mi"` |  |
| nameNode.service.annotations | object | `{}` |  |
| nameNode.service.loadBalancerIP | string | `nil` |  |
| nameNode.service.port | int | `80` |  |
| nameNode.service.type | string | `"ClusterIP"` |  |
| nodemanager.httpPort | int | `8042` |  |
| nodemanager.httpsPort | int | `443` |  |
| nodemanager.pdbMinAvailable | int | `3` |  |
| nodemanager.port | int | `8088` |  |
| nodemanager.replicas | int | `3` |  |
| nodemanager.resources.limits.cpu | string | `"4000m"` |  |
| nodemanager.resources.limits.memory | string | `"8192Mi"` |  |
| nodemanager.resources.requests.cpu | string | `"4000m"` |  |
| nodemanager.resources.requests.memory | string | `"8192Mi"` |  |
| persistence.dataNode.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.dataNode.enabled | bool | `false` |  |
| persistence.dataNode.size | string | `"200Gi"` |  |
| persistence.dataNode.storageClass | string | `nil` |  |
| persistence.nameNode.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.nameNode.enabled | bool | `false` |  |
| persistence.nameNode.size | string | `"50Gi"` |  |
| persistence.nameNode.storageClass | string | `nil` |  |
| prometheus.exporter.enabled | bool | `true` |  |
| prometheus.exporter.image.pullPolicy | string | `"IfNotPresent"` |  |
| prometheus.exporter.image.repository | string | `"marcelmay/hadoop-hdfs-fsimage-exporter"` |  |
| prometheus.exporter.image.tag | float | `1.3` |  |
| prometheus.exporter.port | int | `5556` |  |
| resourcemanager.httpPort | int | `80` |  |
| resourcemanager.httpsPort | int | `443` |  |
| resourcemanager.pdbMinAvailable | int | `1` |  |
| resourcemanager.port | int | `8088` |  |
| resourcemanager.replicas | int | `1` |  |
| resourcemanager.resources.limits.cpu | string | `"2000m"` |  |
| resourcemanager.resources.limits.memory | string | `"4096Mi"` |  |
| resourcemanager.resources.requests.cpu | string | `"500m"` |  |
| resourcemanager.resources.requests.memory | string | `"1024Mi"` |  |
| resourcemanager.service.annotations | object | `{}` |  |
| resourcemanager.service.loadBalancerIP | string | `nil` |  |
| resourcemanager.service.port | int | `80` |  |
| resourcemanager.service.type | string | `"ClusterIP"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)