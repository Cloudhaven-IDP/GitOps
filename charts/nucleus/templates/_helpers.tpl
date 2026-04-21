{{/*
Expand the name of the chart.
*/}}
{{- define "soma-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "soma-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Common labels applied to all resources.
*/}}
{{- define "soma-app.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{ include "soma-app.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
{{- end }}

{{/*
Selector labels — used by Service and Deployment matchLabels.
*/}}
{{- define "soma-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "soma-app.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Service account name.
*/}}
{{- define "soma-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- include "soma-app.fullname" . }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
ExternalSecret-generated K8s secret name.
*/}}
{{- define "soma-app.secretName" -}}
{{- printf "%s-secrets" (include "soma-app.fullname" .) }}
{{- end }}

{{/*
ConfigMap name.
*/}}
{{- define "soma-app.configMapName" -}}
{{- printf "%s-config" (include "soma-app.fullname" .) }}
{{- end }}

{{/*
Validate: KEDA and HPA are mutually exclusive.
*/}}
{{- define "soma-app.validateScaling" -}}
{{- if and .Values.keda.enabled .Values.hpa.enabled }}
{{- fail "Cannot enable both keda and hpa simultaneously. Choose one." }}
{{- end }}
{{- end }}
