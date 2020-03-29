{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "airflow.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "airflow.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "airflow.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "airflow.global.labels" -}}
helm.sh/chart: {{ include "airflow.chart" . }}
{{ include "airflow.global.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
{{- define "airflow.webserver.labels" -}}
{{ include "airflow.webserver.selectorLabels" . }}
{{- end -}}
{{- define "airflow.scheduler.labels" -}}
{{ include "airflow.scheduler.selectorLabels" . }}
{{- end -}}
{{- define "airflow.worker.labels" -}}
{{ include "airflow.worker.selectorLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "airflow.global.selectorLabels" -}}
app.kubernetes.io/name: {{ include "airflow.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- define "airflow.webserver.selectorLabels" -}}
app.kubernetes.io/component: webserver
{{- end -}}
{{- define "airflow.scheduler.selectorLabels" -}}
app.kubernetes.io/component: scheduler
{{- end -}}
{{- define "airflow.worker.selectorLabels" -}}
app.kubernetes.io/component: worker
{{- end -}}



{{/*
Create the name of the service account to use
*/}}
{{- define "airflow.webserver.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ printf "%s-webserver" (default (include "airflow.fullname" .) .Values.serviceAccount.webserver.name) }}
{{- else -}}
    {{ printf "%s-webserver" (default "default" .Values.serviceAccount.webserver.name) }}
{{- end -}}
{{- end -}}
{{- define "airflow.scheduler.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ printf "%s-scheduler" (default (include "airflow.fullname" .) .Values.serviceAccount.scheduler.name) }}
{{- else -}}
    {{ printf "%s-scheduler" (default "default" .Values.serviceAccount.scheduler.name) }}
{{- end -}}
{{- end -}}
{{- define "airflow.worker.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ printf "%s-worker" (default (include "airflow.fullname" .) .Values.serviceAccount.worker.name) }}
{{- else -}}
    {{ printf "%s-worker" (default "default" .Values.serviceAccount.worker.name) }}
{{- end -}}
{{- end -}}


{{- define "airflow.dagsFolder" -}}
{{- if .Values.config.AIRFLOW__CORE__DAGS_FOLDER -}}
    {{ .Values.config.AIRFLOW__CORE__DAGS_FOLDER }}
{{- else -}}
    {{ printf "%s/dags" .Values.airflowHome }}
{{- end -}}
{{- end -}}
