{{/*
Create the name of the secret to use
*/}}
{{- define "cloudflare-access-webhook-redirect.access-secretName" -}}
{{- if .Values.application.cloudflareAccess.secretName }}
{{- .Values.application.cloudflareAccess.secretName }}
{{- else }}
{{- include "common.fullname" . }}
{{- end }}
{{- end }}