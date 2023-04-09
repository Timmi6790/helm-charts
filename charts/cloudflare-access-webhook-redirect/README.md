# cloudflare-access-webhook-redirect

### Installation

1. ````helm repo add timmi6790 https://timmi6790.github.io/helm-charts````

2. Overwrite values

```yaml
image:
  repository: timmi6790/cloudflare-access-webhook-redirect
  tag: 0.1.5
  pullPolicy: IfNotPresent

application:
  logLevel: info
  sentryDsn: ""
  server:
    port: 8080
    host: 0.0.0.0

  handler:
    targetBase: ""
    paths: {}

  cloudflareAccess:
    # Existing secret name with the cloudflare access tokens with client_id and client_secret
    secretName: ""

service:
  type: ClusterIP
  port: 80

ingress:
  enabled: false
  ingressClassName: "nginx"
  annotations: { }
  hosts: [ ]
  tls: [ ]

resources:
  limits:
    memory: 15Mi
  requests:
    memory: 10Mi
```

3. Install the helm chart

```shell
helm install cloudflare-access-webhook-redirect \
  --create-namespace \
  --namespace ca-webhook-redirect  \
  timmi6790/netcup-offer-bot
```