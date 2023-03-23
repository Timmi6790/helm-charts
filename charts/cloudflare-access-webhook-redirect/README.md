# cloudflare-access-webhook-redirect

### Installation

1. ````helm repo add timmi6790 https://timmi6790.github.io/helm-charts````

2. Overwrite values

```yaml
image:
  repository: timmi6790/cloudflare-access-webhook-redirect
  tag: latest
  pullPolicy: IfNotPresent

env:
  logLevel: info

server:
  port: 8080
  host: 0.0.0.0

handler:
  targetBase: ""
  paths: [ ]

cloudflareAccess:
  # Existing secret name with the cloudflare access tokens with client_id and client_secret
  secretName: ""

resources:
  limits:
    memory: 10Mi
  requests:
    memory: 5Mi
```

3. Install the helm chart

```shell
helm install cloudflare-access-webhook-redirect \
  --create-namespace \
  --namespace ca-webhook-redirect  \
  timmi6790/netcup-offer-bot
```