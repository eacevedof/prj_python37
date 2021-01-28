pyinstaller /app/pyprint/public/main.py -F \
--workpath "/app/compiled/build" \
--distpath "/app/compiled/dist" \
--name "pyprint-linux" \
--icon='icon.icns' \
--clean