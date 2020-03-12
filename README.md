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
