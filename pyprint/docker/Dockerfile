FROM python:3.8

#RUN: ejecuta comandos en el momento de la creacion de la imagen
RUN apt-get update && \
    apt-get -y install --no-install-recommends \
    vim

COPY ./docker/.bashrc /root/.bashrc
COPY ./docker/entrypoint.sh /usr/src/entrypoint.sh
RUN chmod +x /usr/src/entrypoint.sh

WORKDIR /pyprint