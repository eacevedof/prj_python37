#!&usr/local/bin/bash
PYTHONOPTIMIZE=1

pyinstaller ./pyprint/public/main.py -F \
--workpath "./compiled/win/build" \
--distpath "./compiled/win/dist" \
--specpath "./compiled/win" \
--onefile --nowindow \
--name "pyprint-win" \
--hidden-import uvicorn.logging \
--hidden-import uvicorn.loops \
--hidden-import uvicorn.loops.auto \
--hidden-import uvicorn.protocols \
--hidden-import uvicorn.protocols.http \
--hidden-import uvicorn.protocols.http.auto \
--hidden-import uvicorn.protocols.websockets \
--hidden-import uvicorn.protocols.websockets.auto \
--hidden-import uvicorn.lifespan \
--hidden-import uvicorn.lifespan.on \
--clean 
#--upx-dir=/usr/local/share/ \
#    myscript.spec
# pyinstaller: error: argument --log-level: invalid choice: 'WARNING' (choose from 'TRACE', 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')

# para ejecutar el compilado ./pyprint-linux
