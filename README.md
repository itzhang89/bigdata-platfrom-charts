# Bigdata Platform On K8s

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/bigdata-charts)](https://artifacthub.io/packages/search?ts_query_web=bigdata-charts&sort=relevance&page=1)

A Bigdata Platform chart for Kubernetes.

## Requirements

- A ready k8s cluster with enabled the default storageclass and ingress.
- Install the [helm/helm: The Kubernetes Package Manager](https://github.com/helm/helm#install)
- Install
  the [helmfile/helmfile: Declaratively deploy your Kubernetes manifests, Kustomize configs, and Charts as Helm releases in one shot](https://github.com/helmfile/helmfile#installation)

## Getting Started

```bash
$ git clone https://github.com/yutianaiqingtian/bigdata-platfrom-charts && cd bigdata-platfrom-charts
$ helmfile apply
```

