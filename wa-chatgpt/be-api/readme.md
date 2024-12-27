### python
- [pip install openai==1.45.0](https://github.com/openai/openai-python/tree/main)
- hostings python: 
  - [https://www.pythonanywhere.com/](https://www.pythonanywhere.com/)
  - [https://www.alwaysdata.com/en/](https://www.alwaysdata.com/en/)
  ```sh
  requests==2.32.3
  openai==1.45.0
  jsonfy==0.4
  flask==3.0.3
  uvicorn==0.30.6
  asgiref==3.8.1
  ```
## start project
```sh
cd C:\projects\prj_python37\wa-chatgpt/be-api/venv/Scripts
activate

# o
cd C:\projects\prj_python37\wa-chatgpt\be-api

cd fe-flet
# create virtualenv
python -m venv venv
# activate virtualenv
.\venv\Scripts\activate
# estando en py-api
pip install -r requirements.txt
# run server (be-api)
# uvicorn main:app --reload
```

## postgres db:
- https://github.com/eacevedof/prj_docker_lamp/tree/main/postgres

### commands
```sh
cd C:/projects/prj_python37/wa-chatgpt/be-api
python -m console.devops.run_migrations_command
```

### pythonanywhere:
- https://help.pythonanywhere.com/pages/Flask/
- https://www.pythonanywhere.com/user/eaf/files/var/www/eaf_pythonanywhere_com_wsgi.py?edit
- https://www.pythonanywhere.com/user/eduardoaf/webapps/#tab_id_eduardoaf_pythonanywhere_com
```sh
cat /var/log/eaf.pythonanywhere.com.error.log
cat /var/log/eaf.pythonanywhere.com.server.log

#LINUX
mkvirtualenv --python=/usr/bin/python3.10 api-virtualenv
pip install -r requirements.txt

# ==============================================
# pythonanywhere_com_wsgi.py
import sys
path = '<home>py-apps/wa-chatgpt/be-api'
if path not in sys.path:
   sys.path.insert(0, path)

from main import app_flask as application
```

#### whatsapp:
```sh
# send whatsapp message

curl -i -X POST https://graph.facebook.com/v20.0/1076378991030422/messages \
-H 'Authorization: Bearer EAAFZCoM5eKPwBO2RLqG03WZBCgFowotttozU5xqIuuHtHumttbUmGxTLfX4yH0wrM05crm6iqZARNrZCbsh5yINtMZA1rrdfSTQJEZBJUPzVmJrlZAcnMBX5ysp3eb5Guc4Wn7WqzZCgHV8mNTlpJabQRROxCKfpflfxi5ji4PqteKXRfWVts5de2qvPqHkoSLp47N95NmX4TPdMw9iZCbxopUu12MMJhaFDZBr8kZD' \
-H 'Content-Type: application/json' \
-d '{
  "messaging_product": "whatsapp",
  "to": "35629160706",
  "type": "template",
  "template": {
    "name": "hello_world",
    "language": {
      "code": "en_US"
    }
  }
}'
```
#### python errors:
```sh
TypeError: Flask.__call__() missing 1 required positional argument: 'start_response'
INFO:     127.0.0.1:62234 - "GET /favicon.ico HTTP/1.1" 500 Internal Server Error
ERROR:    Exception in ASGI application
Traceback (most recent call last):
  File "<prj-dir>wa-chtgpt\venv\Lib\site-packages\uvicorn\protocols\http\h11_impl.py", line 406, in run_asgi
    result = await app(  # type: ignore[func-returns-value]
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<prj-dir>wa-chtgpt\venv\Lib\site-packages\uvicorn\middleware\proxy_headers.py", line 70, in __call__
    return await self.app(scope, receive, send)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<prj-dir>wa-chtgpt\venv\Lib\site-packages\uvicorn\middleware\asgi2.py", line 14, in __call__
    instance = self.app(scope)
               ^^^^^^^^^^^^^^^
TypeError: Flask.__call__() missing 1 required positional argument: 'start_response'
```