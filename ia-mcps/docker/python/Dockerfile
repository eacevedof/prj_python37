#docker/python/Dockerfile — LOCAL (código por bind-mount, uvicorn --reload)
FROM python:3.13-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       git curl vim \
       libcairo2 libpango-1.0-0 libpangoft2-1.0-0 \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /appdata/www

WORKDIR /appdata/www

# El código vive en backend_web/ (estilo mcp-tools / ocr-documents); contexto de
# build = raíz del repo.
COPY backend_web/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
