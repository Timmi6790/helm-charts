# s3-bucket-perma-link

![Version: 1.0.5](https://img.shields.io/badge/Version-1.0.5-informational?style=flat-square) ![AppVersion: v0.2.2](https://img.shields.io/badge/AppVersion-v0.2.2-informational?style=flat-square)

This chart deploys a simple web server that provides permanent links to specific S3 bucket resources. It allows you to define static URL paths that always point to specific files in your S3 buckets.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- S3-compatible storage with access credentials

## Get Repository Info

```shell
helm repo add timschoenle https://timschoenle.github.io/helm-charts
helm repo update
```

## Install Chart

```shell
helm install [RELEASE_NAME] timschoenle/s3-bucket-perma-link \
  --namespace [NAMESPACE] \
  --create-namespace \
  --set application.s3.secretName="s3-credentials"
```

## Upgrade Chart

```shell
helm upgrade [RELEASE_NAME] timschoenle/s3-bucket-perma-link \
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
| application.handler.entries | object | `{}` | Handler configuration defining static routes and their S3 mappings. Each key represents a URL path, and the value is a list of "bucket,file" pairs. Example: ```yaml entries:   myfile: ["bucket1,file.txt"]   mydir: ["bucket2,dir/index.html"] ``` |
| application.logLevel | string | `"info"` | Log level for application output. |
| application.s3 | object | `{"host":"s3.amazon.com","region":"eu-central-1","secretName":""}` | Configuration for connecting to an S3-compatible service. |
| application.s3.host | string | `"s3.amazon.com"` | S3-compatible API endpoint. Example: "https://s3.amazonaws.com" or "https://minio.yourdomain.com" |
| application.s3.region | string | `"eu-central-1"` | AWS region or S3 region identifier. Used for authenticating with region-specific endpoints. |
| application.s3.secretName | string | `""` | Name of an existing Kubernetes Secret containing S3 credentials. The secret must include `access_key` and `secret_key` fields. |
| application.sentryDsn | string | `""` | Sentry DSN for error tracking and reporting. Leave empty to disable Sentry integration. |
| application.server | object | `{"host":"0.0.0.0","port":8080}` | HTTP server configuration. Defines where the application listens for incoming connections. |
| application.server.host | string | `"0.0.0.0"` | Host address to bind the HTTP server. Typically `0.0.0.0` to listen on all network interfaces. |
| application.server.port | int | `8080` | Port number the server listens on. |
| image.pullPolicy | string | `"IfNotPresent"` | Kubernetes image pull policy. Determines when the image should be pulled from the registry. |
| image.repository | string | `"timmi6790/s3-bucket-perma-link"` | Container image repository where the application image is stored. Usually points to Docker Hub or a private registry. Example: ghcr.io/your-org/s3-bucket-perma-link |
| image.tag | string | `"v0.2.2@sha256:242b6ae9e2b6856c8b60ddbab2b7dc747741ff400a0e0c279106a2174bd31101"` | Container image tag to deploy. Pin to a version for predictable deployments rather than using "latest". |
| ingress.annotations | object | `{}` | Custom annotations for the Ingress resource. Useful for configuring ingress controllers (e.g., cert-manager, rate limits). |
| ingress.enabled | bool | `false` | Enable or disable Kubernetes Ingress resource creation. Set to `true` to expose the service externally via Ingress. |
| ingress.hosts | list | `[]` | List of host configurations for the Ingress. Each host defines rules for routing external traffic. Example: ```yaml hosts:   - host: s3.example.com     paths:       - path: /         pathType: Prefix ``` |
| ingress.ingressClassName | string | `"nginx"` | Ingress class to use (e.g., "nginx", "traefik"). Should match your cluster’s ingress controller configuration. |
| ingress.tls | list | `[]` | TLS configuration for securing ingress connections. Example: ```yaml tls:   - secretName: s3-cert     hosts:       - s3.example.com ``` |
| podSecurityContext.fsGroup | int | `1000` | Group ID for file system access |
| podSecurityContext.runAsNonRoot | bool | `true` | Run pod as non-root user |
| podSecurityContext.runAsUser | int | `1000` | User ID to run as |
| resources.limits | object | `{"memory":"20Mi"}` | Resource limits define the maximum resources the container can use. |
| resources.limits.memory | string | `"20Mi"` | Maximum memory allocation for the container. |
| resources.requests | object | `{"memory":"15Mi"}` | Resource requests define the guaranteed resources reserved for the container. |
| resources.requests.memory | string | `"15Mi"` | Minimum memory requested by the container. |
| securityContext.allowPrivilegeEscalation | bool | `false` | Allow privilege escalation |
| securityContext.capabilities.drop | list | `["ALL"]` | Linux capabilities to drop |
| securityContext.readOnlyRootFilesystem | bool | `true` | Mount root filesystem as read-only. Next.js ISR requires write access to update prerender cache. Set to true only if your app doesn't use ISR. |
| service.port | int | `80` | Port that the Kubernetes Service will expose. Typically maps to `application.server.port`. |
| service.type | string | `"ClusterIP"` | Kubernetes Service type that exposes the application. |
| serviceAccount.annotations | object | `{}` | Additional annotations for the service account |
| serviceAccount.automountToken | bool | `false` | Whether to automount the service account token |
| serviceAccount.create | bool | `true` | Whether to create a dedicated service account |
| serviceAccount.name | string | `""` | Custom service account name (auto-generated if empty) |

## S3 Secret Configuration

Create a Kubernetes secret with your S3 credentials:

```bash
kubectl create secret generic s3-credentials \
  --namespace [NAMESPACE] \
  --from-literal=access_key='your-access-key' \
  --from-literal=secret_key='your-secret-key'
```

The secret must contain the following keys:
- `access_key`: Your S3 access key
- `secret_key`: Your S3 secret key

## Path Configuration

Define URL paths that map to S3 bucket files using the `application.handler.entries` configuration:

```yaml
application:
  handler:
    entries:
      # URL path -> ["bucket-name,path/to/file"]
      myfile:
        - "my-bucket,documents/file.pdf"
      report:
        - "reports-bucket,2024/annual-report.pdf"
```

With this configuration:
- `http://your-service/myfile` will serve `documents/file.pdf` from `my-bucket`
- `http://your-service/report` will serve `2024/annual-report.pdf` from `reports-bucket`

## Examples

### Minimal Configuration

```yaml
application:
  handler:
    entries:
      myfile:
        - "my-bucket,path/to/file.txt"

  s3:
    secretName: "s3-credentials"
    host: "s3.amazonaws.com"
    region: "us-east-1"
```

### With Custom S3 Endpoint (MinIO, etc.)

```yaml
application:
  handler:
    entries:
      data:
        - "data-bucket,exports/data.csv"
      backup:
        - "backup-bucket,latest/backup.tar.gz"

  s3:
    secretName: "s3-credentials"
    host: "minio.example.com:9000"
    region: "us-east-1"

resources:
  limits:
    memory: 30Mi
  requests:
    memory: 20Mi
```

### With Ingress and TLS

```yaml
application:
  handler:
    entries:
      report:
        - "reports-bucket,2024/report.pdf"
      data:
        - "data-bucket,exports/data.csv"

  s3:
    secretName: "s3-credentials"
    host: "s3.eu-central-1.amazonaws.com"
    region: "eu-central-1"

ingress:
  enabled: true
  ingressClassName: "nginx"
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
  hosts:
    - host: files.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: files-tls
      hosts:
        - files.example.com
```

### Advanced Configuration with Multiple Files

```yaml
application:
  logLevel: debug

  handler:
    entries:
      # Multiple files can be served from different buckets
      latest-report:
        - "company-reports,2024/q4-report.pdf"
      user-guide:
        - "documentation,guides/user-guide.pdf"
      api-docs:
        - "documentation,api/v2/openapi.yaml"
      backup:
        - "backups,daily/latest.tar.gz"

  s3:
    secretName: "s3-credentials"
    host: "s3.amazonaws.com"
    region: "us-east-1"

service:
  type: ClusterIP
  port: 80

resources:
  limits:
    memory: 25Mi
  requests:
    memory: 15Mi
```

## How It Works

1. The service receives a request at a defined path (e.g., `/myfile`)
2. It looks up the path in the `entries` configuration
3. It retrieves the corresponding file from the S3 bucket
4. The file is served directly to the client

This is useful for:
- Providing stable URLs to frequently changing S3 objects
- Creating short, memorable links to S3 resources
- Simplifying access to S3 files without exposing bucket structure

## Source Code

* <https://github.com/timschoenle/s3-bucket-perma-link>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Tim Schönle | <contact@tim-schoenle.de> |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)

