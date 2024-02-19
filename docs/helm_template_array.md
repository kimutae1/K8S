## values.yaml
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
  Besu:
    xx
```

## tpl
```
{{- define "dd" -}}
  {{- $values := .Values.AppConfigSecret  }}
     values-kind : {{ kindOf $values }}
   {{ range $key, $val :=  $values }}
     key : {{ $key }}
     val : {{ $val }}
     keykind : {{ kindOf $key }}
     valkind : {{ kindOf $val  }}
     {{ $key }} : {{  $val }}
   {{ end }}
{{- end -}}

```

## result
```

# Source: base/templates/start.yaml
aa:
     values-kind : map
   
     key : App
     val : map[ADMIN_VAULT_PRIVATE_KEY:1]
     keykind : string
     valkind : map
     App : map[ADMIN_VAULT_PRIVATE_KEY:1]
   
     key : Besu
     val : xx
     keykind : string
     valkind : string
     Besu : xx
   
     key : Bridge
     val : DB_DATABASE DB_HOST DB_PASSWORD DB_PORT DB_USER KAFKA_BROKERS NODE_ENV PORT
     keykind : string
     valkind : string
     Bridge : DB_DATABASE DB_HOST DB_PASSWORD DB_PORT DB_USER KAFKA_BROKERS NODE_ENV PORT

```

### 여기서 string을 배열로 바꾸려면?
```
{{- define "dd" -}}
  {{- $values := .Values.AppConfigSecret  }}
     values-kind : {{ kindOf $values }}
   {{ range $key, $val := dict $values }}
     key : {{ $key }}
     val : {{ $val }}
     keykind : {{ kindOf $key }}
     valkind : {{ kindOf $val  }}
     {{ $key }} : {{  $val }}
   {{ end }}
{{- end -}}

```

```
aa:
     values-kind : map
   
     key : map[App:map[ADMIN_VAULT_PRIVATE_KEY:1] Besu:xx Bridge:DB_DATABASE DB_HOST DB_PASSWORD DB_PORT DB_USER KAFKA_BROKERS NODE_ENV PORT]
     val : 
     keykind : string
     valkind : string
     map[App:map[ADMIN_VAULT_PRIVATE_KEY:1] Besu:xx Bridge:DB_DATABASE DB_HOST DB_PASSWORD DB_PORT DB_USER KAFKA_BROKERS NODE_ENV PORT] :
```