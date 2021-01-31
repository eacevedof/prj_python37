.\Scripts\activate
pyinstaller src/wsgi.py -F `
--name "pyprint-win" `
--icon='icon.ico' `
--add-data "src\data\*;data" `
--add-data "src\data\*.jpg;data" `
--hidden-import waitress `
--clean


pyinstaller ./pyprint/public/main.py -F \
--workpath "./compiled/win/build" \
--distpath "./compiled/win/dist" \
--name "pyprint-win" \
--hidden-import uvicorn \
--clean 
#--icon='icon.icns' \