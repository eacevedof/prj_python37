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

### La aplicacion:
- consta de entradas que son los archivos de configuración:
  - **config/contexts, credentials y mapping** el principal es **mapping**
  - **mapping**
    - Es un fichero con una lista de movimientos `(origen -> destino)`
    - En estos archivos se configuran los distintos movimientos. El origen, el destino y el mapeo de campos.
    - Tanto origen como destino pueden tener varios tipos:
      - database, api, json, xml, csv, fixed, xls
    - Por ahora se contempla la bd mysql
    - El mapping es el dato de entrada que lleva configurado unos contextos
    - Los **contextos** son repositorios de ubicaciones de fuentes o destinos de datos. Rutas de ficheros y/o configuraciones de acceso en caso de bases de datos y apis
- Una vez configurado un mapping p.e **mapping/elchalan.json** hay que crear una instancia de la clase Etl.
```py
# integrator/etls/elchalan.py
from core.etl import Etl

# le indico que use el mappping: elchalan.json y que use la configuracion: transfer-products
etl1 = Etl("elchalan.json","transfer-products")
etl1.add_query("UPDATE imp_product SET description_full=NULL WHERE description_full='NULL'")
etl1.add_query("UPDATE imp_product SET description_full=NULL WHERE trim(description_full)=''")

# transfer lanza la ejecución. Para este caso se moveran datos de un archivo products.json a una tabla imp_products
# posteriormente se aplicará las queries de UPDATE al estar los datos en imp_products
etl1.transfer()

# despues que tenemos los datos en la tabla de importación hay que pasarlos a la tabla maestra
# le indicamos que use el mismo archivo y que ejecute el movimiento con id: transfer-imp-to-app 
etl1 = Etl("elchalan.json","transfer-imp-to-app")
etl1.transfer()
```