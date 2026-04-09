{{/*
Return the proper image name
*/}}
{{- define "dmp.image" -}}
{{- $registryName := .imageRoot.registry -}}
{{- $repositoryName := .imageRoot.repository -}}
{{- $tag := .imageRoot.tag | toString -}}
{{- if .global }}
    {{- if .global.imageRegistry }}
        {{- $registryName = .global.imageRegistry -}}
    {{- end -}}
{{- end -}}
{{- if $registryName }}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- else }}
{{- printf "%s:%s" $repositoryName $tag -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "dmp.fullname" -}}
{{- default .Chart.Name .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Standard labels
*/}}
{{- define "dmp.labels.standard" -}}
app.kubernetes.io/name: {{ default .Chart.Name .Release.Name | trunc 63 | trimSuffix "-" }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Match labels
*/}}
{{- define "dmp.labels.matchLabels" -}}
app.kubernetes.io/name: {{ default .Chart.Name .Release.Name | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use for SSO
*/}}
{{- define "sso.serviceAccountName" -}}
{{- if .Values.sso.serviceAccount.create }}
{{- default (printf "%s-sso" (include "dmp.fullname" .)) .Values.sso.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.sso.serviceAccount.name }}
{{- end }}
{{- end }}
