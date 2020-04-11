airflow
=======

[Airflow](https://airflow.apache.org/) + Kubernetes Executor+ Git Sync


Current chart version is `1.0.0`

---

## Install Chart

To install the Airflow chart in your Kubernetes cluster, add the `larribas` repository (see main [README](../README.md)), and then run:

```bash
helm install --namespace airflow --name airflow larribas/airflow
```


After the installation succeeds, you can get the Chart's status via:

```bash
helm status airflow
```


You can delete the Chart anytime via:

```bash
helm delete --purge airflow
```


## Service Accounts / RBAC

By default, this Chart creates a new ServiceAccount and runs the deployment under it. You can disable this behavior setting `serviceAccount.create = false`.


## Ingress controller

By default, the ingress controller is disabled. You can, however, instruct the Chart to create an Ingress resource for you with the values you specify.


## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| airflowHome | string | `"/usr/local/airflow"` | Used for mount paths |
| config | object | `{"AIRFLOW__CORE__COLORED_CONSOLE_LOG":"false","AIRFLOW__CORE__ENABLE_XCOM_PICKLING":"false","AIRFLOW__CORE__LOAD_EXAMPLES":"true","AIRFLOW__WEBSERVER__ENABLE_PROXY_FIX":"true"}` | Map of environment variables to inject via envFrom/configMapRef |
| fullnameOverride | string | `""` |  |
| gitSync.dest | string | `"sync"` |  |
| gitSync.enabled | bool | `false` | Whether or not to use a Git repository as the source of truth for the DAGs available to Airflow. When enabled, you need to specify some of the environment variables listed [here](https://github.com/kubernetes/git-sync#parameters) inside of the config value defined above |
| gitSync.root | string | `"/dags"` |  |
| gitSync.ssh.knownHosts | string | `nil` |  |
| gitSync.ssh.privateKey | string | `nil` |  |
| imagePullSecrets | list | `[]` |  |
| images.airflow | object | `{"pullPolicy":"IfNotPresent","repository":"apache/airflow","tag":"1.10.10"}` | The docker image to use for Airflow's webserver, scheduler and kubernetes workers |
| images.gitSync | object | `{"pullPolicy":"IfNotPresent","repository":"k8s.gcr.io/git-sync","tag":"v3.1.5"}` | The docker image to use to synchronize DAGs through Git |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| initializeDatabase | bool | `false` | When set to true, helm will create a one-time job to initialize the database |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources.scheduler | object | `{}` |  |
| resources.webserver | object | `{}` |  |
| secrets | object | `{}` | Map of environment variables to inject via envFrom/secretRef |
| securityContext | object | `{}` |  |
| service.webserver.port | int | `80` |  |
| service.webserver.type | string | `"ClusterIP"` |  |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.scheduler.annotations | object | `{}` |  |
| serviceAccount.scheduler.name | string | `nil` |  |
| serviceAccount.webserver.annotations | object | `{}` |  |
| serviceAccount.webserver.name | string | `nil` |  |
| serviceAccount.worker.annotations | object | `{}` |  |
| serviceAccount.worker.name | string | `nil` |  |
| tolerations | list | `[]` |  |
