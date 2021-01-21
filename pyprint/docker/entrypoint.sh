#!/bin/bash
echo "im /usr/src/entrypoint.sh"
pip install fastapi
pip install uvicorn[standard]

uvicorn main:app --reload
#python /usr/src/pyprint/server.py
#tail -f /dev/null
#uvicorn app.main:app --host 0.0.0.0 --port  8080