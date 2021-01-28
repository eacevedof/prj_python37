# https://github.com/codingforentrepreneurs/30-Days-of-Python/blob/master/tutorial-reference/Day_28/src/wsgi.py

source bin/activate  #activa venv
pyinstaller src/wsgi.py -F \
--name "cfe-os-mac" \
--icon='icon.icns' \
--add-binary='/System/Library/Frameworks/Tk.framework/Tk':'tk' \
--add-binary='/System/Library/Frameworks/Tcl.framework/Tcl':'tcl' \
--add-data "src/data/*:data" \
--add-data "src/data/*.jpg:data" \
--hidden-import waitress \
--clean