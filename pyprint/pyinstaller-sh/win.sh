.\Scripts\activate
pyinstaller src/wsgi.py -F `
--name "pyprint-win" `
--icon='icon.ico' `
--add-data "src\data\*;data" `
--add-data "src\data\*.jpg;data" `
--hidden-import waitress `
--clean