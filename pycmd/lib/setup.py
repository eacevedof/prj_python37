from setuptools import setup

"""
se ejecuta así:

pip install --editable .
"""

setup(
    name                = "pycmd",          #como se va a invocar a nuestra linea de comandos
    version             = "0.1.0",          #sem version
    py_modules          = "['pycmd']",      #se llamará al módulo pycmd
    install_requires    = [                 #se necesita la libreria Click
        "Click",
    ],
    # punto de entrada el método cli dentro de pycmd
    # https://setuptools.readthedocs.io/en/latest/setuptools.html
    entry_points = '''
        [console_scripts]       
        pycmd = src.main:hello
    ''',
)