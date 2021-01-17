FROM python:3.8-alpine

WORKDIR /usr/src/python

#RUN: ejecuta comandos en el momento de la creacion de la imagen
RUN apk add --update vim
RUN pip install pipenv

COPY ./.bashrc /root/.bashrc
COPY ./entrypoint.sh /usr/src/entrypoint.sh

RUN chmod +x /usr/src/entrypoint.sh
