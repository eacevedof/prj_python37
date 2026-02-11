### skills:
- https://skills.sh/
- https://github.com/richardxzl/ai-dev-team

### api:
```sh
curl http://localhost:8303/workitems/tasks?project=temp-workitems&limit=10

curl -s "http://192.168.1.129:8303/workitems/tasks?project=temp-workitems&limit=10" | jq

# Crear épica
curl -X POST http://192.168.1.129:8303/workitems/epics \
-H "Content-Type: application/json" \
-d '{"project":"temp-workitems","title":"Nueva épica","description":"Descripción"}'

# Crear tarea
curl -X POST http://192.168.1.129:8303/workitems/tasks \
-H "Content-Type: application/json" \
-d '{"project":"temp-workitems","epic_id":123,"title":"Nueva tarea 2025-04-15"}'

# Listar tareas
curl "http://192.168.1.129:8303/workitems/tasks?project=temp-workitems&limit=10"

# Actualizar tarea
curl -X PATCH http://192.168.1.129:8303/workitems/tasks/456 \
-H "Content-Type: application/json" \
-d '{"project":"temp-workitems","state":"Active"}'
```