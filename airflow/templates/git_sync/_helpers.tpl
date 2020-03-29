{{- define "airflow.gitSync.configMapName" -}}
    {{ printf "%s-git-sync-ssh" (include "airflow.fullname" .) }}
{{- end -}}

{{- define "airflow.gitSync.secretName" -}}
    {{ printf "%s-git-sync-ssh" (include "airflow.fullname" .) }}
{{- end -}}

{{- define "airflow.gitSync.volumes" }}
volumes:
  - name: git-dags
    emptyDir: {}
  {{- if .Values.gitSync.ssh.privateKey }}
  - name: git-ssh-known-hosts
    configMap:
      name: {{ include "airflow.gitSync.configMapName" . }}
  - name: git-ssh-key
    secret:
      secretName: {{ include "airflow.gitSync.secretName" . }}
  {{- end }}
{{- end }}

{{- define "airflow.gitSync.initContainer" }}
- name: git-clone
  image: "{{ .Values.images.gitSync.repository }}:{{ .Values.images.gitSync.tag }}"
  imagePullPolicy: {{ .Values.images.gitSync.pullPolicy }}
  envFrom:
    - secretRef:
        name: {{ include "airflow.fullname" . }}
    - configMapRef:
        name: {{ include "airflow.fullname" . }}
  env:
  - name: GIT_SYNC_ONE_TIME
    value: "true"
  volumeMounts:
    - name: git-dags
      mountPath: {{ .Values.gitSync.root }}
    {{- if .Values.gitSync.ssh.privateKey }}
    - name: git-ssh-known-hosts
      mountPath: "/etc/git-config"
      readOnly: true
    - name: git-ssh-key
      mountPath: "/etc/git-secret"
      readOnly: true
    {{- end }}
{{- end }}

{{- define "airflow.gitSync.container" }}
- name: git-sync
  image: "{{ .Values.images.gitSync.repository }}:{{ .Values.images.gitSync.tag }}"
  imagePullPolicy: {{ .Values.images.gitSync.pullPolicy }}
  envFrom:
    - secretRef:
        name: {{ include "airflow.fullname" . }}
    - configMapRef:
        name: {{ include "airflow.fullname" . }}
  volumeMounts:
    - name: git-dags
      mountPath: {{ .Values.gitSync.root }}
    {{- if .Values.gitSync.ssh.privateKey }}
    - name: git-ssh-known-hosts
      mountPath: "/etc/git-config"
      readOnly: true
    - name: git-ssh-key
      mountPath: "/etc/git-secret"
      readOnly: true
    {{- end }}
{{- end }}
