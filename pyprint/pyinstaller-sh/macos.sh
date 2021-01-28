# https://github.com/codingforentrepreneurs/30-Days-of-Python/blob/master/tutorial-reference/Day_28/src/wsgi.py

source bin/activate  #activa venv
pyinstaller src/wsgi.py -F \  #Create a one-file bundled executable.
--name "cfe-os-mac" \         #Name to assign to the bundled app and spec file (default: first script’s basename)
--icon='icon.icns' \

#Additional binary files to be added to the executable.
--add-binary='/System/Library/Frameworks/Tcl.framework/Tcl':'tcl' \
--add-binary='/System/Library/Frameworks/Tk.framework/Tk':'tk' \ 

#Additional non-binary files or folders to be added to the executable. 
#The path separator is platform specific, os.pathsep (which is ; on Windows and : 
#on most unix systems) is used. This option can be used multiple times.
--add-data "src/data/*:data" \
--add-data "src/data/*.jpg:data" \

#Name an import not visible in the code of the script(s). This option can be used multiple times.
--hidden-import waitress \
--clean