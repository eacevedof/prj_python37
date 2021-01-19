FROM python:3.8

WORKDIR /usr/src/python

#RUN: ejecuta comandos en el momento de la creacion de la imagen
# RUN apt-get update install vim
# RUN pip install pipenv

COPY ./docker/.bashrc /root/.bashrc
COPY ./docker/entrypoint.sh /usr/src/entrypoint.sh
RUN chmod +x /usr/src/entrypoint.sh

WORKDIR /usr/src/pyprint