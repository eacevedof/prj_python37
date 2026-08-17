# Imagen para DESARROLLO LOCAL.
#
# Solo instala las dependencias de Python. El codigo NO se copia: llega por
# bind-mount desde el compose, para que al guardar un fichero uvicorn recargue
# solo.
#
# El front tampoco esta aqui: en desarrollo lo sirve Vite en el 5173 con recarga
# automatica, y su proxy manda `/api` a este contenedor. Si quieres probar el
# front compilado tal como saldra en produccion, usa `make up-prod-local`.
FROM python:3.12-slim

# UNA sola carpeta de trabajo, la misma en los tres entornos: /app.
# La estructura de dentro es identica a la del repositorio.
#
# En el proyecto del que viene este patron, la imagen local y la de produccion
# usaban carpetas distintas, y eso hace que "funciona en local" deje de
# significar nada. Si cambias esto, cambialo en los DOS Dockerfile.
WORKDIR /app

# Se copia solo el fichero de dependencias, y ANTES que el codigo. Es la unica
# optimizacion de este fichero, y merece la pena: Docker guarda en cache cada
# instruccion, asi que mientras no toques requirements.txt no vuelve a instalar
# nada aunque cambies el codigo mil veces.
COPY backend_web/requirements.txt ./backend_web/requirements.txt
RUN pip install --no-cache-dir -r backend_web/requirements.txt

WORKDIR /app/backend_web

# El comando real esta en el compose, para tenerlo a la vista junto a los
# puertos y los volumenes.
CMD ["uvicorn", "public.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
