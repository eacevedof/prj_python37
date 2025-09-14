#!&usr/local/bin/bash
PYTHONOPTIMIZE=1

pyinstaller ./pyprint/public/main.py -F \
--workpath "./compiled/macos/build" \
--distpath "./compiled/macos/dist" \
--specpath "./compiled/macos" \
--onefile --nowindow \
--name "pyprint-macos" \
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
# para ejecutar el compilado ./pyprint-macos
