FROM python:3.8-alpine

WORKDIR /usr/src/python

#RUN: ejecuta comandos en el momento de la creacion de la imagen
RUN apk add --update vim
RUN pip install pipenv

COPY ./.bashrc /root/.bashrc
COPY ./entrypoint.sh /usr/src/entrypoint.sh

WORKDIR /usr/src/pyprint
# COPY ../pyprint/. /usr/src/pyprint # error out of context
COPY $HOME/projects/prj_python37/pyprint/pyprint/* /usr/src/pyprint/

# CMD  vs ENTRYPOINT:
# cmd: se ejecuta al arrancar el contenedor
CMD ["chmod +x /usr/src/entrypoint.sh","python","/usr/src/pyprint/server.py"]
