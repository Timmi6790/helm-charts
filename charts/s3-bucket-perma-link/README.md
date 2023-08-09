# s3-bucket-perma-link

### Installation

1. ````helm repo add timmi6790 https://timmi6790.github.io/helm-charts````

2. Overwrite values

```yaml
image:
  repository: timmi6790/s3-bucket-perma-link
  tag: 0.2.0
  pullPolicy: IfNotPresent

application:
  logLevel: info
  sentryDsn: ""
  server:
    port: 8080
    host: 0.0.0.0

  handler:
    entries: { }
      # Path: bucket,file
      # 4tv#Sjfpj&:
    #   - bucket,file.txt
    # hGEvxxML5*:
    #   - bucket2,dir/file.txt

  s3:
    # Existing secret name with the cloudflare access tokens with access_key and secret_key
    secretName: ""
    host: "s3.amazon.com"
    region: "eu-central-1"

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
    memory: 20Mi
  requests:
    memory: 15Mi
```

3. Install the helm chart

```shell
helm install s3-bucket-perma-link \
  --create-namespace \
  --namespace s3-bucket-perma-link  \
  timmi6790/s3-bucket-perma-link
```