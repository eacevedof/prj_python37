### Guía
- Intento seguir la estructur de: 
    [Upload (php)](https://github.com/eacevedof/prj_upload/tree/master/backend/php)


### Compilación
- **linux (Docker)**
    - Hay un alias **linux** que ejecuta `/bin/bash /app/pyinstaller-sh/linux.sh`
- **windows**
    - posicionandonos en la raíz (a la altura de docker-compose.yml)
    - ejecutamos: 
        - `/usr/bin/bash pyinstaller-sh/win.sh`

## Error
- root@py38:/app/compiled/linux/dist# sh pyprint-linux
pyprint-linux: 1: pyprint-linux: Syntax error: "(" unexpected
    - habia que usar bash
- Me daba un problema de recursion infinita con fastapi
    - habia que desinstalar pydantic que viene por defecto e instalar desde github
    ```sh
    pip uninstall pydantic
    pip install git+git://github.com/samuelcolvin/pydantic@master#egg=pydantic
    ```
