# cloudflare-access-webhook-redirect

![Version: 2.0.2](https://img.shields.io/badge/Version-2.0.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.3.3](https://img.shields.io/badge/AppVersion-v0.3.3-informational?style=flat-square)

A Helm chart for Cloudflare Access Webhook Redirect

A Helm chart for deploying the Cloudflare Access Webhook Redirect service. This service acts as an authentication proxy that validates requests using Cloudflare Access Service Auth tokens before forwarding them to target backend services.

## Use Case

This is particularly useful for protecting webhook endpoints or APIs that don't have built-in authentication, by leveraging Cloudflare Access for secure authentication and authorization.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- A Cloudflare Access application with Service Auth credentials
- Target backend service to proxy requests to

## Get Repository Info

```shell
helm repo add timmi6790 https://timmi6790.github.io/helm-charts
helm repo update
```

## Install Chart

```shell
helm install [RELEASE_NAME] timmi6790/cloudflare-access-webhook-redirect \
  --namespace [NAMESPACE] \
  --create-namespace \
  --set application.handler.targetBase="http://backend:8080" \
  --set application.cloudflareAccess.clientId="your-client-id" \
  --set application.cloudflareAccess.clientSecret="your-client-secret"
```

## Upgrade Chart

```shell
helm upgrade [RELEASE_NAME] timmi6790/cloudflare-access-webhook-redirect \
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
| affinity | object | `{}` | Pod affinity rules @schema type: object @schema |
| application.cloudflareAccess.secretName | string | `""` | Existing secret name containing Cloudflare Access credentials Must contain client_id and client_secret keys @schema type: string @schema |
| application.handler.paths | object | `{}` | Path configurations with allowed HTTP methods Example:   api/webhook:     - ALL   test:     - GET     - POST @schema type: object @schema |
| application.handler.targetBase | string | `""` | Base URL for redirect targets @schema type: string @schema |
| application.logLevel | string | `"info"` | Application log level Options: debug, info, warn, error @schema enum: [debug, info, warn, error] @schema |
| application.sentryDsn | string | `""` | Sentry DSN for error tracking (empty disables) @schema type: string @schema |
| application.server.host | string | `"0.0.0.0"` | Server bind address @schema type: string @schema |
| application.server.port | int | `8080` | HTTP server port @schema type: integer @schema |
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler (HPA) @schema type: boolean @schema |
| autoscaling.maxReplicas | int | `5` | Maximum replicas @schema type: integer minimum: 1 @schema |
| autoscaling.minReplicas | int | `1` | Minimum replicas @schema type: integer minimum: 1 @schema |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization (%) @schema type: integer minimum: 1 maximum: 100 @schema |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target memory utilization (%) @schema type: integer minimum: 1 maximum: 100 @schema |
| fullnameOverride | string | `""` | Override the full release name @schema type: string @schema |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy Valid options: Always, IfNotPresent, Never @schema enum: [Always, IfNotPresent, Never] @schema |
| image.repository | string | `"timmi6790/cloudflare-access-webhook-redirect"` | Container image repository (e.g. docker.io/user/image) @schema type: string @schema |
| image.tag | string | `"v0.3.3"` | Container image tag (version) @schema type: string @schema |
| imagePullSecrets | list | `[]` | Optional image pull secrets for private registries @schema type: array @schema |
| ingress.annotations | object | `{}` | Additional ingress annotations Example:   cert-manager.io/cluster-issuer: letsencrypt-prod   nginx.ingress.kubernetes.io/rate-limit: "100" @schema type: object @schema |
| ingress.enabled | bool | `false` | Enable ingress resource @schema type: boolean @schema |
| ingress.hosts | list | `[]` | Host definitions for ingress Example:   - host: example.local     paths:       - path: /         pathType: Prefix @schema type: array @schema |
| ingress.ingressClassName | string | `"nginx"` | Ingress class name (e.g. nginx) @schema type: string @schema |
| ingress.tls | list | `[]` | TLS configuration for ingress Example:   - secretName: example-tls     hosts:       - example.local @schema type: array @schema |
| livenessProbe.enabled | bool | `true` | Enable liveness probe @schema type: boolean @schema |
| livenessProbe.failureThreshold | int | `3` | Failure threshold @schema type: integer @schema |
| livenessProbe.httpGet.path | string | `"/health"` | Health check path @schema type: string @schema |
| livenessProbe.httpGet.port | string | `"http"` | Health check port @schema type: string @schema |
| livenessProbe.initialDelaySeconds | int | `10` | Initial delay before probe starts @schema type: integer @schema |
| livenessProbe.periodSeconds | int | `10` | Probe frequency @schema type: integer @schema |
| livenessProbe.timeoutSeconds | int | `5` | Probe timeout @schema type: integer @schema |
| nameOverride | string | `""` | Override the chart name @schema type: string @schema |
| networkPolicy.egress | list | `[]` | Egress rules @schema type: array @schema |
| networkPolicy.enabled | bool | `false` | Enable Kubernetes NetworkPolicy @schema type: boolean @schema |
| networkPolicy.ingress | list | `[]` | Ingress rules @schema type: array @schema |
| networkPolicy.policyTypes | list | `["Ingress","Egress"]` | Policy types (Ingress/Egress) @schema type: array @schema |
| nodeSelector | object | `{}` | Node selector labels for scheduling @schema type: object @schema |
| podAnnotations | object | `{}` | Additional annotations for the Pod metadata @schema type: object @schema |
| podDisruptionBudget.enabled | bool | `false` | Enable PodDisruptionBudget @schema type: boolean @schema |
| podDisruptionBudget.maxUnavailable | int | `1` | Maximum unavailable pods @schema type: [integer, "null"] @schema |
| podDisruptionBudget.minAvailable | int | `1` | Minimum available pods @schema type: [integer, "null"] @schema |
| podLabels | object | `{}` | Additional labels for the Pod metadata @schema type: object @schema |
| podSecurityContext.fsGroup | int | `10001` | Group ID for file system access @schema type: integer @schema |
| podSecurityContext.runAsNonRoot | bool | `true` | Run pod as non-root user @schema type: boolean @schema |
| podSecurityContext.runAsUser | int | `10001` | User ID to run as @schema type: integer @schema |
| priorityClassName | string | `""` | Optional Kubernetes PriorityClass name @schema type: string @schema |
| readinessProbe.enabled | bool | `true` | Enable readiness probe @schema type: boolean @schema |
| readinessProbe.failureThreshold | int | `3` | Failure threshold @schema type: integer @schema |
| readinessProbe.httpGet.path | string | `"/health"` | Health check path @schema type: string @schema |
| readinessProbe.httpGet.port | string | `"http"` | Health check port @schema type: string @schema |
| readinessProbe.initialDelaySeconds | int | `5` | Initial delay before probe starts @schema type: integer @schema |
| readinessProbe.periodSeconds | int | `5` | Probe frequency @schema type: integer @schema |
| readinessProbe.timeoutSeconds | int | `3` | Probe timeout @schema type: integer @schema |
| replicaCount | int | `1` | Number of replicas to deploy Must be at least 1 @schema type: integer minimum: 1 @schema |
| resources.limits.cpu | string | `"100m"` | Maximum CPU usage (e.g. 100m = 0.1 core) @schema type: string @schema |
| resources.limits.memory | string | `"15Mi"` | Maximum memory usage (e.g. 64Mi) @schema type: string @schema |
| resources.requests.cpu | string | `"10m"` | Guaranteed CPU request @schema type: string @schema |
| resources.requests.memory | string | `"10Mi"` | Guaranteed memory request @schema type: string @schema |
| securityContext.allowPrivilegeEscalation | bool | `false` | Allow privilege escalation @schema type: boolean @schema |
| securityContext.capabilities.drop | list | `["ALL"]` | Linux capabilities to drop @schema type: array @schema |
| securityContext.readOnlyRootFilesystem | bool | `false` | Mount root filesystem as read-only @schema type: boolean @schema |
| service.annotations | object | `{}` | Additional service annotations @schema type: object @schema |
| service.port | int | `80` | Service port @schema type: integer @schema |
| service.type | string | `"ClusterIP"` | Kubernetes service type Options: ClusterIP, NodePort, LoadBalancer @schema enum: [ClusterIP, NodePort, LoadBalancer] @schema |
| serviceAccount.annotations | object | `{}` | Additional annotations for the service account @schema type: object @schema |
| serviceAccount.automountToken | bool | `false` | Whether to automount the service account token @schema type: boolean @schema |
| serviceAccount.create | bool | `true` | Whether to create a dedicated service account @schema type: boolean @schema |
| serviceAccount.name | string | `""` | Custom service account name (auto-generated if empty) @schema type: string @schema |
| startupProbe.enabled | bool | `true` | Enable startup probe @schema type: boolean @schema |
| startupProbe.failureThreshold | int | `30` | Failure threshold @schema type: integer @schema |
| startupProbe.httpGet.path | string | `"/health"` | Health check path @schema type: string @schema |
| startupProbe.httpGet.port | string | `"http"` | Health check port @schema type: string @schema |
| startupProbe.initialDelaySeconds | int | `0` | Initial delay before probe starts @schema type: integer @schema |
| startupProbe.periodSeconds | int | `5` | Probe frequency @schema type: integer @schema |
| startupProbe.successThreshold | int | `1` | Success threshold @schema type: integer @schema |
| startupProbe.timeoutSeconds | int | `3` | Probe timeout @schema type: integer @schema |
| tolerations | list | `[]` | Tolerations for taints @schema type: array @schema |
| topologySpreadConstraints | list | `[]` | Pod topology spread constraints for availability @schema type: array @schema |
| volumeMounts | list | `[]` | Additional volume mounts (e.g., /cache) @schema type: array @schema |
| volumes | list | `[]` | Additional volumes (e.g., cache, tmp) @schema type: array @schema |

## Cloudflare Access Configuration

### Option 1: Using Existing Secret

Create a Kubernetes secret with your Cloudflare Access Service Auth credentials:

```bash
kubectl create secret generic cloudflare-access-secret \
  --namespace [NAMESPACE] \
  --from-literal=client_id='your-client-id' \
  --from-literal=client_secret='your-client-secret'
```

Then reference it in your values:

```yaml
application:
  cloudflareAccess:
    secretName: "cloudflare-access-secret"
```

### Option 2: Inline Credentials (Not Recommended for Production)

```yaml
application:
  cloudflareAccess:
    clientId: "your-client-id"
    clientSecret: "your-client-secret"
```

## Path Configuration

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

Available HTTP methods: `GET`, `POST`, `PUT`, `DELETE`, `PATCH`, `HEAD`, `OPTIONS`, or `ALL` for all methods.

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
      api/status:
        - GET

  cloudflareAccess:
    secretName: "cloudflare-access-secret"

ingress:
  enabled: true
  ingressClassName: "nginx"
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
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
      api/events:
        - POST
        - GET

  cloudflareAccess:
    secretName: "cloudflare-access-secret"

autoscaling:
  enabled: true
  minReplicas: 3
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70
  targetMemoryUtilizationPercentage: 80

topologySpreadConstraints:
  - maxSkew: 1
    topologyKey: kubernetes.io/hostname
    whenUnsatisfiable: ScheduleAnyway
    labelSelector:
      matchLabels:
        app.kubernetes.io/name: cloudflare-access-webhook-redirect

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

### With Network Policy

```yaml
application:
  handler:
    targetBase: "http://backend-service:8080"
    paths:
      api/webhook:
        - ALL

  cloudflareAccess:
    secretName: "cloudflare-access-secret"

networkPolicy:
  enabled: true
  policyTypes:
    - Ingress
    - Egress
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
          port: 8080
    - to:
        - namespaceSelector: {}
      ports:
        - protocol: TCP
          port: 443
```

### Production Setup with Monitoring

```yaml
replicaCount: 2

application:
  logLevel: info
  sentryDsn: "https://your-sentry-dsn@sentry.io/project"

  handler:
    targetBase: "http://backend-service:8080"
    paths:
      api/webhook:
        - POST
      api/data:
        - GET
        - POST

  cloudflareAccess:
    secretName: "cloudflare-access-secret"

resources:
  limits:
    cpu: 100m
    memory: 15Mi
  requests:
    cpu: 10m
    memory: 10Mi

startupProbe:
  enabled: true
  initialDelaySeconds: 0
  periodSeconds: 5
  failureThreshold: 30

livenessProbe:
  enabled: true
  initialDelaySeconds: 10
  periodSeconds: 10

readinessProbe:
  enabled: true
  initialDelaySeconds: 5
  periodSeconds: 5

podDisruptionBudget:
  enabled: true
  minAvailable: 1
```

## How It Works

1. Client sends a request to the service (e.g., via Ingress)
2. The service validates the request against the configured paths and HTTP methods
3. It uses Cloudflare Access Service Auth credentials to authenticate the request
4. If authenticated, the request is proxied to the target backend service
5. The response from the backend is returned to the client

This provides a zero-trust authentication layer for services that don't have built-in authentication.

## Security Considerations

- **Always use secrets** for Cloudflare Access credentials in production
- **Enable NetworkPolicy** to restrict ingress/egress traffic
- **Use TLS/HTTPS** via Ingress with proper certificates
- **Monitor logs** and consider enabling Sentry for error tracking
- **Set resource limits** to prevent resource exhaustion
- **Use PodDisruptionBudget** for high-availability deployments

## Source Code

* <https://github.com/Timmi6790/cloudflare-access-webhook-redirect>
* <https://github.com/Timmi6790/helm-charts>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Timmi6790 |  | <https://github.com/Timmi6790> |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)

