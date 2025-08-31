# Changelog - FastAPI Anti Phishing API

⬅️ [volver a la api]({{app_base_url}})

#### {{app_version}} - Actualización: {{app_version_update}}
- Migración inicial desde Deno/TypeScript a Python/FastAPI
- Implementación de módulos básicos: Authenticator, Users, Devops, Mailing, Documentation, HealthCheck, StaticAssets
- Sistema de autenticación con tokens de aplicación
- Gestión básica de usuarios
- Sistema de logging y monitoreo de salud
- Componente de mailing con soporte CURL

#### v1.0.0 - Actualización: 2025-08-27
- Primera versión en FastAPI
- Arquitectura hexagonal adaptada a Python
- Sistema de excepciones personalizado
- Middleware de autenticación
- Documentación automática con FastAPI

### TO-DO
- Implementar base de datos PostgreSQL
- Añadir Redis para caché
- Implementar módulos de Phishing y Domains
- Añadir sistema de notificaciones push
- Implementar tests unitarios
- Configurar CI/CD

⬅️ [volver a la api]({{app_base_url}})