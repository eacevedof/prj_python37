### Integraciones
- Mysql - Googlesheets
  - [documentacion](https://developers.google.com/sheets/api/quickstart/python)
- Instalación mysql
  - `python -m pip install mysql-connector`
- Instalación paquetes google sheets
  ```
  pip install gspread
  pip install oauth2client
  ```
- para conseguir la visualizacion entre módulos lo he hecho con:
 - `pipenv install -e .` modo edicion
  - https://realpython.com/pipenv-guide/
  - Esto tampoco soluciona importación entre hermanos :S ya no se que hacer ^^
  - En etls no puedo importar goggleserv
- Para obtener las credenciales hay que hacerlo desde la consola de google
- Se crea un proyecto
- Se habilitan los servicios
- Se genera la credencial del tipo: **Cuentas de servicio**
- Con la cuenta creada, al compartir la hoja de cálculo se ingresa la misma.
  - será del tipo: `<cuetna>@<proyecto>.iam.gserviceaccount.com"`
- estos datos se descargan en un fichero ".json" que es el que se usa en python para la conexión
