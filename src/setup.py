from setuptools import setup

setup(
    name = "pv",                #como se va a invocar a nuestra linea de comandos
    version = "0.1",            #sen version
    py_modules = "['pv']",      #se llamará al módulo pv
    install_requires = [        #se necesita la libreria Click
        "Click",
    ],
    # punto de entrada el método cli dentro de pv
    entry_points = '''
        [console_scripts]       
        pv=pv:cli
    ''',
)