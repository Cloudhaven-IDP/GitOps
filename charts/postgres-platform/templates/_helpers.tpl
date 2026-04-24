{{- define "postgres-platform.clusterName" -}}
{{- required "clusterName is required" .Values.clusterName -}}
{{- end -}}

{{- define "postgres-platform.caSecret" -}}
{{ include "postgres-platform.clusterName" . }}-ca
{{- end -}}

{{- define "postgres-platform.superuserSecret" -}}
{{ include "postgres-platform.clusterName" . }}-superuser
{{- end -}}

{{- define "postgres-platform.issuerName" -}}
{{ include "postgres-platform.clusterName" . }}-ca-issuer
{{- end -}}

{{- define "postgres-platform.serviceAccountName" -}}
{{ include "postgres-platform.clusterName" . }}-eso
{{- end -}}

{{- define "postgres-platform.secretStoreName" -}}
{{ include "postgres-platform.clusterName" . }}-backend
{{- end -}}

{{- define "postgres-platform.labels" -}}
app.kubernetes.io/name: postgres-platform
app.kubernetes.io/db-type: postgresql
app.kubernetes.io/instance: {{ include "postgres-platform.clusterName" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
{{- end -}}
