{{/*
Create the name of the secret to use for GitHub token
*/}}
{{- define "portfolio.secretName" -}}
{{- if .Values.application.github.secretName }}
{{- .Values.application.github.secretName }}
{{- else }}
{{- include "common.fullname" . }}
{{- end }}
{{- end }}
