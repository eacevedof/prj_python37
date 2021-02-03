### Guía
- Intento seguir la estructur de: 
    [Upload (php)](https://github.com/eacevedof/prj_upload/tree/master/backend/php)

### Compilación
- **linux (Docker)**
    - Hay un alias **linux** que ejecuta `/bin/bash /app/pyinstaller-sh/linux.sh`
    - para lanzar el compilado:
        - `<vamos-a-dist-folder>./pyprint-linux`
- **windows**
    - nos posicionandonos en la raíz (a la altura de docker-compose.yml)
    - ejecutamos: 
        - con gitbash.exe
        - `/usr/bin/bash pyinstaller-sh/win.sh`
- **macos**
    - nos posicionamos en la raíz
    - ejecutamos:
        - `/usr/local/bin/bash pyinstaller-sh/macos.sh`
    - para lanzar el compilado:
        - `pyprint/compiled/macos/dist/./pyprint-macos`

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
- --data me da error de binario
    - https://stackoverflow.com/questions/7674790/bundling-data-files-with-pyinstaller-onefile
-  Macos: Can not find path /usr/lib/libSystem.B.dylib
    - si, bien da este error el compilado funciona ^^