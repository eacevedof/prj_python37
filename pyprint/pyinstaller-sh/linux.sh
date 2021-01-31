pyinstaller /app/pyprint/public/main.py -F \
--workpath "/app/compiled/linux/build" \
--distpath "/app/compiled/linux/dist" \
--name "pyprint-linux" \
# --icon='icon.icns' \
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