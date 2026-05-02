{{/*
Expand the name of the chart.
*/}}
{{- define "nucleus.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "nucleus.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Common labels applied to all resources.
*/}}
{{- define "nucleus.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{ include "nucleus.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
{{- end }}

{{/*
Selector labels — used by Service and Deployment matchLabels.
*/}}
{{- define "nucleus.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nucleus.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Service account name.
*/}}
{{- define "nucleus.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- include "nucleus.fullname" . }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
ConfigMap name.
*/}}
{{- define "nucleus.configMapName" -}}
{{- printf "%s-config" (include "nucleus.fullname" .) }}
{{- end }}

{{/*
Validate: KEDA and HPA are mutually exclusive.
*/}}
{{- define "nucleus.validateScaling" -}}
{{- if and .Values.keda.enabled .Values.hpa.enabled }}
{{- fail "Cannot enable both keda and hpa simultaneously. Choose one." }}
{{- end }}
{{- end }}
