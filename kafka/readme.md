● Organización Kafka - Estándares y Convenciones

Estructura de Topics

He implementado la convención estándar de Apache Kafka: <domain>.<entity>.<event-type>

Ejemplos implementados:
- security.user.login - Eventi de login de usuarios
- security.user.password_change - Cambios de contraseña
- security.alert.suspicious_login - Alertas de logins sospechosos
- security.alert.malware_detected - Detección de malware
- monitoring.metrics.collected - Métricas del sistema

Dominios Organizados:

1. Security - Eventos de seguridad
2. Monitoring - Métricas y monitoreo
3. User - Eventos de usuario
4. Alert - Sistema de alertas

Particionado:

- 3 particiones por defecto (configurado en docker-compose)
- Key-based partitioning - Mensajes con la misma key van a la misma partición
- User ID como key para eventos de usuario
- Alert type como key para alertas

Consumer Groups:

- security-event-processors - Procesa eventos de seguridad
- monitoring-processors - Procesa métricas
- generic-processors - Consumidor genérico

Configuraciones de Confiabilidad:

- acks='all' - Espera confirmación de todas las réplicas
- Manual commit - Control exacto sobre offsets
- Graceful shutdown - Manejo de señales SIGINT/SIGTERM
