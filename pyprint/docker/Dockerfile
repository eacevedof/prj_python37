FROM python:3.8-alpine

WORKDIR /usr/src/python

#RUN: ejecuta comandos en el momento de la creacion de la imagen
RUN apk add --update vim
RUN pip install pipenv

COPY ./docker/.bashrc /root/.bashrc
COPY ./docker/entrypoint.sh /usr/src/entrypoint.sh

WORKDIR /usr/src/pyprint
# ADD ../pyprint /usr/src/pyprint
# ADD failed: forbidden path outside the build context: ../pyprint ()

#ADD $HOME/projects/prj_python37/pyprint/pyprint /usr/src/pyprint
# Error: file not found in build context or excluded by .dockerignore: stat projects/prj_python37/pyprint/pyprint: file does not exist

# CMD  vs ENTRYPOINT:
# cmd: se ejecuta al arrancar el contenedor
CMD ["chmod +x /usr/src/entrypoint.sh","python","/usr/src/pyprint/server.py"]
