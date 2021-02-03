#!/usr/bin/bash
#.\Scripts\activate
#pyinstaller src/wsgi.py -F `
#--name "pyprint-win" `
#--icon='icon.ico' `
#--add-data "src\data\*;data" `
#--add-data "src\data\*.jpg;data" `
#--hidden-import waitress `
#--clean
set PYTHONOPTIMIZE=1

# esto no va :s
#--add-data "./pyprint/config/access.json:." \
#--add-data "./pyprint/logs/:." \

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
#--icon='icon.icns' \