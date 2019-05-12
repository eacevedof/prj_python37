"""
Paquete distribuible 0.0.1
tutorial:
    Pildoras informaticas
    Paquetes distribuibles. Vídeo 36
    https://youtu.be/Zf9sN-w0BVE
"""

from setuptools import setup

setup(
    name = "theframework",
    version = "1.0",
    description = "Paquete de redondeo y potencia",
    author = "Eduardoa A. F.",
    author_email = "eacevedof@gmail.com",
    url = "theframework.es",
    license = "MIT",
    packages = [
        "components","dsources","functions","helpers"
    ]
)

"""
Despues de configurar setup (..) hay que ejecutar la consola y posicionarse en la carpeta raiz

Ejecutar comando:
    python setup.py sdist

Esto crea:
    una carpeta dist
        nos encontraremos con un fichero *.tar.gz
    una carpeta theframework.egg-info 
        Tiene información sobre dependencias y licencias

Con el tar.gz existente podemos ejecutar
    pip install <ruta al paquete>\theframework-1.0.tar.gz
    
Para desinstalar:
    pip uninstall theframework
"""