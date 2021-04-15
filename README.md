Forked from larribas/helm-charts, the following is the readme from that repo.

The reason for forking this is:

- Being able to patch and release it myself
- Fix some issues there were in the chart to be able to use it

# Helm Charts

This is my personal Helm Chart repository. You can point helm to it via

```bash
helm repo add larribas https://larribas.me/helm-charts
```

All charts in this repo:

- Rely either on official docker images, or images created and built by me.
- Are pinned to a specific version
- Provide flexibility when choosing the extra Kubernetes artifacts you want to create (RBAC, Ingress, and so on)
- Have worked for me in production at the last time of publication

## Charts

- [MLFlow](mlflow/README.md) (stable and production-ready) - An open source platform for the machine learning lifecycle ([mlflow.org](https://mlflow.org/))
- [Airflow](airflow/README.md) (stable and production-ready) - A platform to programmatically author, schedule and monitor workflows ([apache.airflow.org](https://airflow.apache.org/))

## Maintainer Cheat Sheet

1. Add/modify a chart
1. Update docs with [helm-docs](https://github.com/norwoodj/helm-docs)
1. Bump up the `version` in `<project>/Chart.yaml`
1. Run `helm package <project>` to create a `<project>-<version>.tgz` file
1. Update the repository's index via `helm repo index .`
