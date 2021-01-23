#!/bin/bash
pip install fastapi
pip install uvicorn[standard]
cd public; uvicorn main:app --reload --host 0.0.0.0 --port 8080;
