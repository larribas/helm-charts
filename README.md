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

- [MLFlow](mlflow/README.md) - An open source platform for the machine learning lifecycle ([mlflow.org](https://mlflow.org/))


## Maintainer Cheat Sheet

1. Add/modify a chart
2. Bump up the `version` in `<project>/Chart.yaml`
3. Run `helm package <project>` to create a `<project>-<version>.tgz` file
4. Update the repository's index via `helm repo index .`

