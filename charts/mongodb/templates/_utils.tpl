{{/* vim: set filetype=mustache: */}}
{{/*
Print instructions to get a secret value.
Usage:
{{ include "utils.secret.getvalue" (dict "secret" "secret-name" "field" "secret-value-field" "context" $) }}
*/}}
{{- define "utils.secret.getvalue" -}}
{{- $varname := include "utils.fieldToEnvVar" . -}}
export {{ $varname }}=$(kubectl get secret --namespace {{ .context.Release.Namespace | quote }} {{ .secret }} -o jsonpath="{.data.{{ .field }}}" | base64 --decode)
{{- end -}}

{{/*
Build env var name given a field
Usage:
{{ include "utils.fieldToEnvVar" dict "field" "my-password" }}
*/}}
{{- define "utils.fieldToEnvVar" -}}
  {{- $fieldNameSplit := splitList "-" .field -}}
  {{- $upperCaseFieldNameSplit := list -}}

  {{- range $fieldNameSplit -}}
    {{- $upperCaseFieldNameSplit = append $upperCaseFieldNameSplit ( upper . ) -}}
  {{- end -}}

  {{ join "_" $upperCaseFieldNameSplit }}
{{- end -}}

{{/*
Gets a value from .Values given
Usage:
{{ include "utils.getValueFromKey" (dict "key" "path.to.key" "context" $) }}
*/}}
{{- define "utils.getValueFromKey" -}}
{{- $splitKey := splitList "." .key -}}
{{- $value := "" -}}
{{- $latestObj := $.context.Values -}}
{{- range $splitKey -}}
  {{- if not $latestObj -}}
    {{- printf "please review the entire path of '%s' exists in values" $.key | fail -}}
  {{- end -}}
  {{- $value = ( index $latestObj . ) -}}
  {{- $latestObj = $value -}}
{{- end -}}
{{- printf "%v" (default "" $value) -}} 
{{- end -}}

{{/*
Returns first .Values key with a defined value or first of the list if all non-defined
Usage:
{{ include "utils.getKeyFromList" (dict "keys" (list "path.to.key1" "path.to.key2") "context" $) }}
*/}}
{{- define "utils.getKeyFromList" -}}
{{- $key := first .keys -}}
{{- $reverseKeys := reverse .keys }}
{{- range $reverseKeys }}
  {{- $value := include "utils.getValueFromKey" (dict "key" . "context" $.context ) }}
  {{- if $value -}}
    {{- $key = . }}
  {{- end -}}
{{- end -}}
{{- printf "%s" $key -}} 
{{- end -}}
