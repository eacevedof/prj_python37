FROM python:3.8-alpine

WORKDIR /usr/src/python

#RUN: ejecuta comandos en el momento de la creacion de la imagen
RUN apk add --update vim
RUN pip install pipenv

COPY ./docker/.bashrc /root/.bashrc
COPY ./docker/entrypoint.sh /usr/src/entrypoint.sh
RUN chmod +x /usr/src/entrypoint.sh

WORKDIR /usr/src/pyprint
#COPY ./server.py /usr/src/pyprint
# ADD failed: forbidden path outside the build context: ../pyprint ()

#ADD $HOME/projects/prj_python37/pyprint/pyprint /usr/src/pyprint
# Error: file not found in build context or excluded by .dockerignore: stat projects/prj_python37/pyprint/pyprint: file does not exist

# CMD  vs ENTRYPOINT:
# cmd: se ejecuta al arrancar el contenedor
# este comando se ejecuta por defecto al hacer un docker run, pero se puede sobrescribir si se hace un docker run <imagen> <otro comando>
# CMD [ "python", "/usr/src/pyprint/server.py"]
# CMD [ "tail", "-f /dev/null" ]
#
# ENTRYPOINT es un comando fijo y que no se "puede" sobrescribir, se debe tratar como un ejecutable
# ENTRYPOINT ["python"]
# significa que el comando python se mantendria como un comando fijo en ejecución cuando se levante el contendor y si se le pasa algun
# parametro lo tomará como argumento dentro de ese comando por ejemplo: docker run hola-python hello.py. (hello.py debería estar dentro del contenedor)
# esto puede servir para tener varias imagenes de versiones python y puedes lanzar un script en cada una por separado