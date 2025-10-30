# netcup-offer-bot

![Version: 1.0.7](https://img.shields.io/badge/Version-1.0.7-informational?style=flat-square) ![AppVersion: v1.3.0](https://img.shields.io/badge/AppVersion-v1.3.0-informational?style=flat-square)

RSS feed listener to discord webhook for https://www.netcup-sonderangebote.de/

This chart deploys the Netcup Offer Bot, which monitors https://www.netcup-sonderangebote.de/ RSS feed and sends notifications to Discord webhooks when new offers are available.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- A Discord webhook URL

## Get Repository Info

```shell
helm repo add timmi6790 https://timmi6790.github.io/helm-charts
helm repo update
```

## Install Chart

```shell
helm install [RELEASE_NAME] timmi6790/netcup-offer-bot \
  --namespace [NAMESPACE] \
  --create-namespace \
  --set env.webHook="YOUR_DISCORD_WEBHOOK_URL"
```

## Upgrade Chart

```shell
helm upgrade [RELEASE_NAME] timmi6790/netcup-offer-bot \
  --namespace [NAMESPACE]
```

## Uninstall Chart

```shell
helm uninstall [RELEASE_NAME] --namespace [NAMESPACE]
```

## Configuration

The following table lists the configurable parameters of the chart and their default values.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.checkInterval | int | `180` | Interval in seconds between offer checks. Must be a positive integer (minimum: 1). @schema type: integer minimum: 1 @schema |
| env.logLevel | string | `"info"` | Log level for the application. Valid options: debug, info, warn, error @schema enum: [debug, info, warn, error] @schema |
| env.sentryDns | string | `""` | Sentry DSN for error tracking. Leave empty to disable. @schema type: string @schema |
| env.webHook | string | `""` | Webhook URL to send updates or notifications. @schema type: string @schema |
| image.pullPolicy | string | `"IfNotPresent"` | The image pull policy. Valid options are: Always, IfNotPresent, Never @schema enum: [Always, IfNotPresent, Never] @schema |
| image.repository | string | `"timmi6790/netcup-offer-bot"` | The container image repository. @schema type: string @schema |
| image.tag | string | `"v1.3.0"` | The container image tag. @schema type: string @schema |
| metrics.enabled | bool | `false` | Enable Prometheus metrics endpoint. @schema type: boolean @schema |
| metrics.port | int | `9184` | Port to expose metrics on. @schema type: integer @schema |
| metrics.serviceMonitor | object | `{"interval":"1m","scrapeTimeout":"30s"}` | ServiceMonitor configuration for Prometheus Operator integration. @schema additionalProperties: true @schema |
| metrics.serviceMonitor.interval | string | `"1m"` | Metrics scrape interval (e.g., 1m, 30s). @schema type: string @schema |
| metrics.serviceMonitor.scrapeTimeout | string | `"30s"` | Timeout for metrics scraping (e.g., 30s). @schema type: string @schema |
| persistence.data | object | `{"accessMode":"ReadWriteOnce","size":"10Mi"}` | Configuration for persistent data storage. @schema additionalProperties: true @schema |
| persistence.data.accessMode | string | `"ReadWriteOnce"` | The access mode for the persistent volume. Valid options: ReadWriteOnce, ReadOnlyMany, ReadWriteMany @schema enum: [ReadWriteOnce, ReadOnlyMany, ReadWriteMany] @schema |
| persistence.data.size | string | `"10Mi"` | The storage size requested for the volume. Must be a valid Kubernetes size string (e.g. 10Mi, 1Gi). @schema type: string @schema |
| resources.limits | object | `{"memory":"20Mi"}` | Resource limits for the container. @schema additionalProperties: true @schema |
| resources.limits.memory | string | `"20Mi"` | Maximum allowed memory usage. @schema type: string @schema |
| resources.requests | object | `{"memory":"15Mi"}` | Resource requests for the container. @schema additionalProperties: true @schema |
| resources.requests.memory | string | `"15Mi"` | Minimum guaranteed memory allocation. @schema type: string @schema |

## Examples

### Minimal Configuration

```yaml
env:
  webHook: "https://discord.com/api/webhooks/..."
  checkInterval: 180
```

### Production Setup with Metrics

```yaml
env:
  webHook: "https://discord.com/api/webhooks/..."
  sentryDns: "https://your-sentry-dsn@sentry.io/project"
  checkInterval: 300
  logLevel: info

metrics:
  enabled: true
  port: 9184
  serviceMonitor:
    interval: 1m
    scrapeTimeout: 30s

resources:
  limits:
    memory: 20Mi
  requests:
    memory: 15Mi

persistence:
  data:
    size: 50Mi
```

### With Custom Resource Limits

```yaml
env:
  webHook: "https://discord.com/api/webhooks/..."
  checkInterval: 120
  logLevel: debug

resources:
  limits:
    memory: 30Mi
  requests:
    memory: 20Mi

persistence:
  data:
    accessMode: ReadWriteOnce
    size: 100Mi
```

## Persistence

The bot uses a persistent volume to store its state and track which offers have already been processed. This ensures that notifications aren't duplicated when the pod restarts.

The default storage size is 10Mi, which should be sufficient for most use cases.

## Source Code

* <https://github.com/Timmi6790/netcup-offer-bot>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Timmi6790 | <contact@timmi6790.de> |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)

