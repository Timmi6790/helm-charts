{{/*
Create the name of the secret to use
*/}}
{{- define "s3-bucket-perma-link.s3-secretName" -}}
{{- if .Values.application.s3.secretName }}
{{- .Values.application.s3.secretName }}
{{- else }}
{{- include "common.fullname" . }}
{{- end }}
{{- end }}