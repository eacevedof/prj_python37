#!/bin/bash
python -m pip install --upgrade pip

pip install debugpy
pip install fastapi
pip install uvicorn[standard]
#pip install debugpy -t /tmp

#python -m debugpy --listen 0.0.0.0:5678 --wait-for-client -m uvicorn
#python -m debugpy --listen 0.0.0.0:5678 --wait-for-client -m public/main.py
#python /tmp/debugpy --wait-for-client --listen 0.0.0.0:5678 /pyprint/public/main.py

#python -m debugpy --listen 0.0.0.0:5678 --wait-for-client -m src

#python /tmp/debugpy --wait-for-client --listen 0.0.0.0:5678 -m uvicorn

#python /tmp/debugpy --wait-for-client --listen 0.0.0.0:5678 -m uvicorn main:app 

#https://www.uvicorn.org/settings/
cd public; uvicorn main:app --reload --host 0.0.0.0 --port 8080 --reload-dir "../src"

# python public/main.py

# python -m public/main.py

# esta llamada permite reconocer src como módulo pero no me sirve ya que es solo para debug
# python -m public.main 