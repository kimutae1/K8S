
* map으로 구성 되어 있을 시 type을 검사하여 
  map안의 map을 분기 처리하는 코드
```
{{- define "dd" -}}
  {{- $values := .Values.AppConfigSecret  }}
      values-kind : {{ kindOf $values }}
   {{- range $key, $val :=  $values -}}
    {{- if eq ( $val | kindOf ) "map" }}
     key : {{ $key }}
     val : {{ $val }}
     keykind : {{ kindOf $key }}
     valkind : {{ kindOf $val |toYaml }}
     {{ range $newkey, $newval := $val }}
      {{ $newkey }}
      {{ kindOf $newkey }}
      {{ $newval }}
      {{ kindOf $newval }}
     {{ end }}
    {{ else }}
     {{ $key }} : {{  $val }}
      {{ kindOf $key  }}
      {{ kindOf $val  }}
    {{ end }}
   {{ end }}
{{- end -}}

```

values.yaml
```
AppConfigSecretSelect: Bridge
AppConfigSecret:
  Bridge:
    DB_DATABASE
    DB_HOST
    DB_PASSWORD
    DB_PORT
    DB_USER
    KAFKA_BROKERS
    NODE_ENV
    PORT
  App:
    ADMIN_VAULT_PRIVATE_KEY : 1
    3depth : 
     aa : aa
```


## result
```
# Source: base/templates/start.yaml
aa:
      values-kind : map
     key : App
     val : map[3depth:map[aa:aa] ADMIN_VAULT_PRIVATE_KEY:1]
     keykind : string
     valkind : map
     
      3depth
      string
      map[aa:aa]

```
