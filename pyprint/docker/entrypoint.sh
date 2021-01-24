#!/bin/bash
python -m pip install --upgrade pip
pip install fastapi
pip install uvicorn[standard]
pip install debugpy

#python -m debugpy --listen 0.0.0.0:5678 --wait-for-client -m public/main.py
python -m debugpy --listen 0.0.0.0:5678 --wait-for-client
#https://www.uvicorn.org/settings/
cd public; uvicorn main:app --reload --host 0.0.0.0 --port 8080 --reload-dir "../src"