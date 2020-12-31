### to-do
- debo probar si puedo mover datos entre dos bases de datos en un mismo servidor sin necesidad de pasar por el integrador. 
  - Algo así:
  ```sql
  insert into db1.table_a (f1,f2,f3) 
  select fa as f1, fb as f2, fc as f3
  from db2.table_o 
  where fa>10
  ```
- en el mapper hay que formar una condición concreta dentro de un obj json debería haber una propiedad de consulta libre.
  - Ejemplo:
  ```json
    "source":{
      "format": "database",
      "context":{
        "file": "mysql.json",
        "id": "mysql1",
        "database": "db_tinymarket"
      },
      "table":"imp_product",
      "sql": "SELECT fa as f1, count(fb) as f2 FROM table_orig WHERE 1 AND GROUP BY fa"
    }
  ```
  - La consulta anterior acabaría dentro de una subquery tipo `SELECT * FROM (sql) as imp_product`
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
# ejeacución py main.py

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
- **configuración**
- En config/contexts/mysql.json se agregan las bds origen y/o destino
- En config/mapping/ se crea un json de mapeo de campos origen y destino **eduardoaf.json**
- En etls se crea un namespace (carpeta) **eduardoaf** con su __init__.py
  - En la carpeta anterior hay que crear un módulo eduardoaf.py (puede ser otro nombre) donde se llama a la clase core: **from core.etl import Etl** con el nombre de fichero del mapping.json y el id a ejecutar
- En main.py se importa **eduardoaf.py**  `from etls.eduardoaf.eduardoaf import etl1` hay que comentar lo que no queremos que se ejecute
- lanzamos: **py main.py**

#### **ERROR:** No se inserta en destino y no lanza ningún error
- Parece que esto tiene que ver con el driver. Como que ha cambiado porque ahora hay que ejecutar **commit()** para que se ejecuten las consultas.
- El test no va fino. Parece que el driver, que lleva implicito un socket hay que probarlo con un mock sino da error de socket.
- El campo **datetime.datetime(...)** no da error al hacer el insert. Pensaba que este podía ser el problema.
```
ResourceWarning: unclosed 

<socket.socket fd=5, family=AddressFamily.AF_INET, type=SocketKind.SOCK_STREAM, proto=6, 
laddr=('127.0.0.1', 63999), raddr=('127.0.0.1', 3306)>

fn_method(self, *args, **kwargs)
ResourceWarning: Enable tracemalloc to get the object allocation traceback
```
