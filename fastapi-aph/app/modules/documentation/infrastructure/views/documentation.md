# FastAPI Anti Phishing API - [{{app_version}}](/changelog#{{app_version}})
- Última actualización: {{app_version_update}}

### Introducción
- **`<APP-AUTH-TOKEN>`** Este token identifica directamente al proyecto e indirectamente al cliente que es el propietario.
- para solicitar un token de acceso puede contactar con **info@lazarus.es**

### 1- Configuración global del proyecto.
- Devuelve la configuración a nivel de proyecto. Como los limites del scoring de los dominios.
- La respuesta es un hashmap de clave-valor en formato string.

- **GET**
```
curl --location '{{app_base_url}}/v1/projects/get-project-config' \
--header 'lzrmsaph-auth: <APP-AUTH-TOKEN>'
```

#### respuesta:
```json
{
    "code": 200,
    "status": "success",
    "message": "project config",
    "data": {
        "project_config": [
            {
                "config_key": "DOMAIN_SCORING_CRITICAL_MAX",
                "config_value": "10"
            },
            {
                "config_key": "DOMAIN_SCORING_CRITICAL_MIN",
                "config_value": "7"
            }
        ]
    }
}
```

### 2- Para poder interactuar con la API se necesita tener un usuario.
- **POST**
```
curl --location '{{app_base_url}}/v1/users/create-user' \
--header 'lzrmsaph-auth: <APP-AUTH-TOKEN>' \
--header 'Content-Type: application/json' \
--data '{
    "project_uuid": "prj-generic-0001",
    "project_user_uuid": "usr-009"
}'
```

#### respuesta:
```json
{
    "code": 201,
    "status": "success",
    "message": "user created successfully",
    "data": {
        "user_uuid": "aph-usr-71a24a842b754335a771710b6ab48ff5"
    }
}
```

### Health Check
- **GET**
```
curl --location '{{app_base_url}}/health'
```

#### respuesta:
```json
{
    "code": 200,
    "status": "success",
    "message": "Service is healthy",
    "data": {
        "status": "healthy",
        "timestamp": "2025-08-27T12:00:00.000Z",
        "version": "1.0.0"
    }
}
```

[⬆️ Ir al inicio](#)