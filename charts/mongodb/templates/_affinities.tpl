{{/* vim: set filetype=mustache: */}}

{{/*
Return a soft nodeAffinity definition 
{{ include "affinities.nodes.soft" (dict "key" "FOO" "values" (list "BAR" "BAZ")) -}}
*/}}
{{- define "affinities.nodes.soft" -}}
preferredDuringSchedulingIgnoredDuringExecution:
  - preference:
      matchExpressions:
        key: {{ .key }}
        operator: In
        values:
          {{- range .values }}
          - {{ . }}
          {{- end }}
    weight: 1
{{- end -}}

{{/*
Return a hard nodeAffinity definition
{{ include "affinities.nodes.hard" (dict "key" "FOO" "values" (list "BAR" "BAZ")) -}}
*/}}
{{- define "affinities.nodes.hard" -}}
requiredDuringSchedulingIgnoredDuringExecution:
  nodeSelectorTerms:
    - matchExpressions:
        key: {{ .key }}
        operator: In
        values:
          {{- range .values }}
          - {{ . }}
          {{- end }}
{{- end -}}

{{/*
Return a nodeAffinity definition
{{ include "affinities.nodes" (dict "type" "soft" "key" "FOO" "values" (list "BAR" "BAZ")) -}}
*/}}
{{- define "affinities.nodes" -}}
  {{- if eq .type "soft" }}
    {{- include "affinities.nodes.soft" . -}}
  {{- else if eq .type "hard" }}
    {{- include "affinities.nodes.hard" . -}}
  {{- end -}}
{{- end -}}

{{/*
Return a soft podAffinity/podAntiAffinity definition
{{ include "affinities.pods.soft" (dict "component" "FOO" "context" $) -}}
*/}}
{{- define "affinities.pods.soft" -}}
{{- $component := default "" .component -}}
preferredDuringSchedulingIgnoredDuringExecution:
  - podAffinityTerm:
      labelSelector:
        matchLabels: {{- (include "labels.matchLabels" .context) | nindent 10 }}
          {{- if not (empty $component) }}
          {{ printf "app.kubernetes.io/component: %s" $component }}
          {{- end }}
      namespaces:
        - {{ .context.Release.Namespace }}
      topologyKey: kubernetes.io/hostname
    weight: 1
{{- end -}}

{{/*
Return a hard podAffinity/podAntiAffinity definition
{{ include "affinities.pods.hard" (dict "component" "FOO" "context" $) -}}
*/}}
{{- define "affinities.pods.hard" -}}
{{- $component := default "" .component -}}
requiredDuringSchedulingIgnoredDuringExecution:
  - labelSelector:
      matchLabels: {{- (include "labels.matchLabels" .context) | nindent 8 }}
        {{- if not (empty $component) }}
        {{ printf "app.kubernetes.io/component: %s" $component }}
        {{- end }}
    namespaces:
      - {{ .context.Release.Namespace }}
    topologyKey: kubernetes.io/hostname
{{- end -}}

{{/*
Return a podAffinity/podAntiAffinity definition
{{ include "affinities.pods" (dict "type" "soft" "key" "FOO" "values" (list "BAR" "BAZ")) -}}
*/}}
{{- define "affinities.pods" -}}
  {{- if eq .type "soft" }}
    {{- include "affinities.pods.soft" . -}}
  {{- else if eq .type "hard" }}
    {{- include "affinities.pods.hard" . -}}
  {{- end -}}
{{- end -}}
