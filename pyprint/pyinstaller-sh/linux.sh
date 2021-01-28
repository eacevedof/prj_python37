pyinstaller /app/pyprint/public/main.py -F \
--workpath "/app/compiled/linux/build" \
--distpath "/app/compiled/linux/dist" \
--name "pyprint-linux" \
--icon='icon.icns' \
--clean