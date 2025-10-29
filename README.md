# Helm Charts

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/timmi6790)](https://artifacthub.io/packages/search?repo=timmi6790)

A collection of Helm charts for Kubernetes applications, focusing on utility services and automation tools.

## TL;DR

```bash
helm repo add timmi6790 https://timmi6790.github.io/helm-charts
helm repo update
helm search repo timmi6790
helm install my-release timmi6790/<chart-name>
```

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

### Add Helm Repository

Once Helm is set up properly, add the repository as follows:

```bash
helm repo add timmi6790 https://timmi6790.github.io/helm-charts
```

### Update Repository

You can then run `helm search repo timmi6790` to see the available charts.

```bash
helm repo update
```

### Install a Chart

To install a chart from this repository:

```bash
helm install my-release timmi6790/<chart-name>
```

To install with custom values:

```bash
helm install my-release timmi6790/<chart-name> -f values.yaml
```

### Upgrade a Chart

To upgrade an existing release:

```bash
helm upgrade my-release timmi6790/<chart-name>
```

### Uninstall a Chart

To uninstall a chart:

```bash
helm uninstall my-release
```

## Available Charts

| Chart | Description | Chart Version |
|-------|-------------|---------------|
| [cloudflare-access-webhook-redirect](./charts/cloudflare-access-webhook-redirect) | Middleware service that authenticates requests using Cloudflare Access tokens before forwarding them to target services | Check [Chart.yaml](./charts/cloudflare-access-webhook-redirect/Chart.yaml) |
| [netcup-offer-bot](./charts/netcup-offer-bot) | Automated bot for monitoring and processing Netcup offers | Check [Chart.yaml](./charts/netcup-offer-bot/Chart.yaml) | 
| [s3-bucket-perma-link](./charts/s3-bucket-perma-link) | Service for generating and managing permanent links to S3 bucket objects | Check [Chart.yaml](./charts/s3-bucket-perma-link/Chart.yaml) |

## Chart Documentation

For detailed documentation on each chart, including configuration options and examples, please refer to the individual chart's README:

```bash
# View chart README
helm show readme timmi6790/<chart-name>

# View all available values
helm show values timmi6790/<chart-name>

# View chart information
helm show chart timmi6790/<chart-name>
```

You can also browse the documentation for each chart in the [charts directory](./charts/).


### Reporting Issues

If you encounter any issues or have feature requests:
1. Check if the issue already exists in the [issue tracker](https://github.com/Timmi6790/helm-charts/issues)
2. If not, create a new issue with detailed information
3. Include Kubernetes and Helm versions
4. Provide relevant logs and configuration
