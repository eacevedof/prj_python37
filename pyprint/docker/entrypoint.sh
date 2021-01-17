#!/bin/sh
echo "im /usr/src/entrypoint.sh"
python /usr/src/pyprint/server.py
tail -f /dev/null
