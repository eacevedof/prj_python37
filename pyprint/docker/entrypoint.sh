#!/bin/bash
python -m pip install --upgrade pip
pip install fastapi
pip install uvicorn[standard]

#https://www.uvicorn.org/settings/
cd public; uvicorn main:app --reload --host 0.0.0.0 --port 8080 --reload-dir "../src"
