# Helm starter

The [`application/`](application/) chart is a small baseline for deploying a stateless HTTP service. Copy/adapt it into an application repository, own its values there, and pin its chart/dependencies where applicable. The shared `helm-deploy.yml` reusable workflow deploys the chart with a required SHA-256 image digest and uses Helm's `--atomic` and `--wait` behavior.

Use one reviewed values file per environment, keep secrets out of Git and Helm values, and configure environment protection and an environment-scoped AWS role in GitHub. Extend the chart with organization-required probes, resources, service account/workload identity, ingress, network policy, autoscaling, and policy labels before production.
