# netcup-offer-bot

### Installation

1. ````helm repo add timmi6790 https://timmi6790.github.io/helm-charts````

2. Overwrite values

```yaml
image:
  repository: timmi6790/netcup-offer-bot
  tag: latest
  pullPolicy: IfNotPresent

env:
  # Optional sentry url
  sentryDns: ""
  # Discord webhook url
  webHook: ""
  # Check interval in seconds
  checkInterval: 180
  # Optional log level
  logLevel: info

persistence:
  data:
    accessMode: ReadWriteOnce
    size: 10Mi

metrics:
  enabled: false
  port: 9184
  serviceMonitor:
    interval: 1m
    scrapeTimeout: 30s

resources:
  limits:
    memory: 10Mi
  requests:
    memory: 5Mi
```

3. Install the helm chart

```shell
helm install netcup-offer-bot \
  --create-namespace \
  --namespace netcup \
  timmi6790/netcup-offer-bot
```

#### Environment variables

| Environment    	  | Required 	  | Description                         	                                             |
|-------------------|-------------|-----------------------------------------------------------------------------------|
| SENTRY_DSN     	  | 	           | Sentry dns                          	                                             |
| WEB_HOOK       	  | X         	 | Discord webhook                     	                                             |
| CHECK_INTERVAL 	  | X         	 | RSS feed check interval in seconds 	                                              |
| METRIC_IP       	 | 	           | Prometheus exporter ip [Default: 0.0.0.0]                           	             |
| METRIC_PORT     	 | 	           | Prometheus exporter port [Default: 9184]                            	             |
| LOG_LEVEL  	      | 	           | Log level [FATAL, ERROR, WARN, INFO, DEBUG, TRACE, ALL]                         	 |