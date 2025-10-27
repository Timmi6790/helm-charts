# Cloudflare Access Webhook Redirect

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: v0.3.2](https://img.shields.io/badge/AppVersion-v0.3.2-informational?style=flat-square)

A Helm chart for deploying the Cloudflare Access Webhook Redirect service. This service acts as a middleware that authenticates requests using Cloudflare Access tokens before forwarding them to target services.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- A Cloudflare Access application with Service Auth credentials

## Get Repository Info

```shell
helm repo add timmi6790 https://timmi6790.github.io/helm-charts
helm repo update
```

## Install Chart

**Important:** Configure the required values before installation.

```shell
# Install with custom values file
helm install [RELEASE_NAME] timmi6790/cloudflare-access-webhook-redirect \
  --namespace [NAMESPACE] \
  --create-namespace \
  --values values.yaml

# Install with command line parameters
helm install [RELEASE_NAME] timmi6790/cloudflare-access-webhook-redirect \
  --namespace [NAMESPACE] \
  --create-namespace \
  --set application.handler.targetBase="http://backend:8080" \
  --set application.cloudflareAccess.clientId="your-client-id" \
  --set application.cloudflareAccess.clientSecret="your-client-secret"
```

_See [configuration](#Configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Upgrade Chart

```shell
helm upgrade [RELEASE_NAME] timmi6790/cloudflare-access-webhook-redirect \
  --namespace [NAMESPACE] \
  --values values.yaml
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

## Uninstall Chart

```shell
helm uninstall [RELEASE_NAME] --namespace [NAMESPACE]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

```shell
# Helm 3
helm show values timmi6790/cloudflare-access-webhook-redirect
```

### Required Configuration

The following values must be configured for the chart to work:

| Parameter | Description | Example |
|-----------|-------------|---------|
| `application.handler.targetBase` | Base URL of the target service to forward requests to | `http://backend-service:8080` |
| `application.handler.paths` | Path configurations with allowed HTTP methods | See [Path Configuration](#path-configuration) |
| `application.cloudflareAccess.secretName` | Existing secret with Cloudflare Access credentials | `cloudflare-secret` |

**OR**

| Parameter | Description | Example |
|-----------|-------------|---------|
| `application.cloudflareAccess.clientId` | Cloudflare Access Client ID | `abc123...` |
| `application.cloudflareAccess.clientSecret` | Cloudflare Access Client Secret | `xyz789...` |

### Path Configuration

Define which paths should be proxied and which HTTP methods are allowed:

```yaml
application:
  handler:
    paths:
      # Allow all HTTP methods for webhook endpoint
      api/webhook:
        - ALL
      
      # Allow specific methods
      api/data:
        - GET
        - POST
      
      # Multiple endpoints
      health:
        - GET
      metrics:
        - GET
```

### Values

#### Core Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` | Number of replicas |
| image.repository | string | `"timmi6790/cloudflare-access-webhook-redirect"` | Container image repository |
| image.tag | string | `"v0.3.2"` | Container image tag |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| imagePullSecrets | list | `[]` | Image pull secrets |
| nameOverride | string | `""` | Override chart name |
| fullnameOverride | string | `""` | Override fully qualified app name |

#### Application Configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| application.logLevel | string | `"info"` | Log level (trace, debug, info, warn, error) |
| application.sentryDsn | string | `""` | Sentry DSN for error tracking |
| application.server.port | int | `8080` | Server port |
| application.server.host | string | `"0.0.0.0"` | Server host |
| application.handler.targetBase | string | `""` | Base URL for forwarding requests (required) |
| application.handler.paths | object | `{}` | Path configurations with allowed HTTP methods (required) |

#### Cloudflare Access Configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| application.cloudflareAccess.secretName | string | `""` | Existing secret name with credentials |
| application.cloudflareAccess.clientId | string | `""` | Client ID (creates secret if provided) |
| application.cloudflareAccess.clientSecret | string | `""` | Client secret (creates secret if provided) |

**Secret Format:** The secret must contain `client_id` and `client_secret` keys.

#### Service Configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.type | string | `"ClusterIP"` | Kubernetes service type |
| service.port | int | `80` | Service port |
| service.annotations | object | `{}` | Service annotations |

#### Ingress Configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.enabled | bool | `false` | Enable ingress |
| ingress.ingressClassName | string | `"nginx"` | Ingress class name |
| ingress.annotations | object | `{}` | Ingress annotations |
| ingress.hosts | list | `[]` | Ingress hosts configuration |
| ingress.tls | list | `[]` | Ingress TLS configuration |

#### Resources

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| resources.limits.cpu | string | `"100m"` | CPU limit |
| resources.limits.memory | string | `"15Mi"` | Memory limit |
| resources.requests.cpu | string | `"10m"` | CPU request |
| resources.requests.memory | string | `"10Mi"` | Memory request |

#### Health Checks

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| startupProbe.enabled | bool | `true` | Enable startup probe |
| startupProbe.failureThreshold | int | `30` | Startup probe failure threshold |
| startupProbe.periodSeconds | int | `5` | Startup probe period |
| livenessProbe.enabled | bool | `true` | Enable liveness probe |
| livenessProbe.periodSeconds | int | `10` | Liveness probe period |
| readinessProbe.enabled | bool | `true` | Enable readiness probe |
| readinessProbe.periodSeconds | int | `5` | Readiness probe period |

#### Autoscaling

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling.enabled | bool | `false` | Enable horizontal pod autoscaling |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas |
| autoscaling.maxReplicas | int | `5` | Maximum number of replicas |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target memory utilization percentage |

#### Security Context

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.create | bool | `true` | Create service account |
| serviceAccount.annotations | object | `{}` | Service account annotations |
| serviceAccount.name | string | `""` | Service account name |
| serviceAccount.automountToken | bool | `false` | Automount service account token |
| podSecurityContext.runAsNonRoot | bool | `true` | Run as non-root user |
| podSecurityContext.runAsUser | int | `10001` | User ID to run as |
| podSecurityContext.fsGroup | int | `10001` | File system group |
| securityContext.allowPrivilegeEscalation | bool | `false` | Allow privilege escalation |
| securityContext.capabilities.drop | list | `["ALL"]` | Drop all capabilities |
| securityContext.readOnlyRootFilesystem | bool | `false` | Read-only root filesystem |

#### Advanced Configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| priorityClassName | string | `""` | Priority class name for pod scheduling |
| podAnnotations | object | `{}` | Annotations to add to pods |
| podLabels | object | `{}` | Labels to add to pods |
| topologySpreadConstraints | list | `[]` | Topology spread constraints |
| nodeSelector | object | `{}` | Node selector |
| tolerations | list | `[]` | Tolerations |
| affinity | object | `{}` | Affinity rules |
| volumes | list | `[]` | Additional volumes |
| volumeMounts | list | `[]` | Additional volume mounts |
| podDisruptionBudget.enabled | bool | `false` | Enable pod disruption budget |
| podDisruptionBudget.minAvailable | int | `1` | Minimum available pods |
| networkPolicy.enabled | bool | `false` | Enable network policy |
| networkPolicy.policyTypes | list | `["Ingress","Egress"]` | Network policy types |
| networkPolicy.ingress | list | `[]` | Ingress rules |
| networkPolicy.egress | list | `[]` | Egress rules |

## Examples

### Minimal Configuration

```yaml
application:
  handler:
    targetBase: "http://backend-service:8080"
    paths:
      api/webhook:
        - POST

  cloudflareAccess:
    clientId: "your-client-id-here"
    clientSecret: "your-client-secret-here"
```

### With Ingress and TLS

```yaml
application:
  handler:
    targetBase: "http://backend-service:8080"
    paths:
      api/webhook:
        - POST

  cloudflareAccess:
    secretName: "cloudflare-access-secret"

ingress:
  enabled: true
  ingressClassName: "nginx"
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    nginx.ingress.kubernetes.io/rate-limit: "100"
  hosts:
    - host: webhook.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: webhook-tls
      hosts:
        - webhook.example.com
```

### High Availability Setup

```yaml
replicaCount: 3

application:
  handler:
    targetBase: "http://backend-service:8080"
    paths:
      api/webhook:
        - POST
  
  cloudflareAccess:
    secretName: "cloudflare-access-secret"

autoscaling:
  enabled: true
  minReplicas: 3
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70
  targetMemoryUtilizationPercentage: 70

topologySpreadConstraints:
  - maxSkew: 1
    topologyKey: kubernetes.io/hostname
    whenUnsatisfiable: ScheduleAnyway
    labelSelector:
      matchLabels:
        app.kubernetes.io/name: cloudflare-access-webhook-redirect
  - maxSkew: 1
    topologyKey: topology.kubernetes.io/zone
    whenUnsatisfiable: ScheduleAnyway

podDisruptionBudget:
  enabled: true
  minAvailable: 2

resources:
  limits:
    cpu: 200m
    memory: 30Mi
  requests:
    cpu: 50m
    memory: 20Mi
```

### Production Setup with Network Policies

```yaml
application:
  logLevel: warn
  sentryDsn: "https://your-sentry-dsn@sentry.io/project"
  handler:
    targetBase: "http://backend-service:8080"
    paths:
      api/webhook:
        - POST
  
  cloudflareAccess:
    secretName: "cloudflare-access-secret"

networkPolicy:
  enabled: true
  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              name: ingress-nginx
      ports:
        - protocol: TCP
          port: 8080
  egress:
    - to:
        - namespaceSelector: {}
      ports:
        - protocol: TCP
          port: 443
    - to:
        - podSelector:
            matchLabels:
              app: backend-service
      ports:
        - protocol: TCP
          port: 8080

priorityClassName: "high-priority"

podSecurityContext:
  runAsNonRoot: true
  runAsUser: 10001
  fsGroup: 10001
  seccompProfile:
    type: RuntimeDefault

securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop:
      - ALL
  readOnlyRootFilesystem: true
```

### Using Existing Secret

If you prefer to manage the Cloudflare Access credentials separately:

```bash
# Create the secret
kubectl create secret generic cloudflare-access-secret \
  --namespace ca-webhook-redirect \
  --from-literal=client_id='your-client-id' \
  --from-literal=client_secret='your-client-secret'
```

```yaml
# values.yaml
application:
  handler:
    targetBase: "http://backend-service:8080"
    paths:
      api/webhook:
        - POST
  
  cloudflareAccess:
    secretName: "cloudflare-access-secret"
```

## Troubleshooting

### Checking Pod Status

```bash
kubectl get pods -n [NAMESPACE] -l app.kubernetes.io/name=cloudflare-access-webhook-redirect
```

### Viewing Logs

```bash
kubectl logs -n [NAMESPACE] -l app.kubernetes.io/name=cloudflare-access-webhook-redirect
```

### Testing the Service

```bash
# Port-forward to test locally
kubectl port-forward -n [NAMESPACE] svc/[RELEASE_NAME]-cloudflare-access-webhook-redirect 8080:80

# Test health endpoint
curl http://localhost:8080/health
```

## Source Code

* <https://github.com/Timmi6790/cloudflare-access-webhook-redirect>
* <https://github.com/Timmi6790/helm-charts>

## Support

For issues and feature requests, please visit:
- [Helm Charts Repository](https://github.com/Timmi6790/helm-charts/issues)
- [Application Repository](https://github.com/Timmi6790/cloudflare-access-webhook-redirect/issues)
