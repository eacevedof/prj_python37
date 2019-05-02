# Probando el pip install pipenv
## [Fazt](https://youtu.be/-XIsKyNWILo)

- `pip install pipenv` instala el módulo del entorno virutal
- `pipenv shell` carga el entorno
    - crea un nuevo entorno virtual
- `pipenv install django`
- `pipenv install djangorestframework`
    - se ha creado un archivo Pipfile.lock
- `$ pipenv --venv` nos dice la ruta donde se instala el entorno virtual `.virtualenvs\apirest-wO8eG7Mj`
- Si queremos instalar un módolo con el típico **pip install** lo hariamos con **pipenv install**
- `pipenv lock -r` muestra todo lo que está instalado en mi entorno virtual
- `pipenv install --verbose -r requirements.txt` instala lo que está definido en el fichero
- `pipenv exit` salgo del entorno virtual
- `pipenv --rm` elimino mi entorno virtual

```ssh 
$ pip freeze
Django==2.2
djangorestframework==3.9.2
pytz==2019.1
sqlparse==0.3.0
```

- `django-admin startproject learnlang .` Crea el proyecto 
- `django-admin startapp theapp` Crea la app theapp
- [creating-a-rest-apiwebservice by Fernando Rodrigues](http://fernandorodrigues.pro/creating-a-rest-apiwebservice-with-django-rest-framework-and-mysql-using-python-3/)
- `pip3 install mysqlclient` instala el driver
    - Da error (que sorpresa! ¬¬)
    - Intento [pip install mysqlclient-1.3.7-cp35-cp35m-win32.whl](https://www.pythoniza.me/instalando-mysqlclient-en-windows/)
        - error
    - [Drivers](https://www.lfd.uci.edu/~gohlke/pythonlibs/#mysqlclient)
    - Intento `pip3 install https://download.lfd.uci.edu/pythonlibs/u2hcgva4/mysqlclient-1.4.2-cp37-cp37m-win32.whl`
        - ok
- `pipenv install mysqlclient` 
    - Da error (lloro en silencio ~~!)
    - Supuestamente porque hay que hacerlo con el fichero requirements.txt ^^ [más info al final](https://pypi.org/project/mysqlclient/)
    ```
    NOTE: Wheels for Windows may be not released with source package. 
    You should pin version in your requirements.txt to avoid trying to install newest source package.
    ```
- `pipenv install -r requirements.txt` Lo he ejecutado así y parece que va
    ```js 
    mysqlclient==1.4.2
    django
    djangorestframework
    ```
- `python manage.py inspectdb` 
    - Da error ( :) )
        - `ModuleNotFoundError: No module named 'MySQLdb'`
        - Lo que parece es que django usa Mysqldb ^^ [está obsoleto?](http://fernandorodrigues.pro/creating-a-rest-apiwebservice-with-django-rest-framework-and-mysql-using-python-3/)
- Al final la instalación hay que hacerla así:
    - `pipenv install --skip-lock -r requirements.txt`
    - `pipenv install --skip-lock django-debug-toolbar`
    - esto no generará el fichero Pipfile.lock (no se pa q sirve tampoco)
    - **requirements.txt**
    ```js
    https://download.lfd.uci.edu/pythonlibs/u2hcgva4/mysqlclient-1.4.2-cp37-cp37m-win32.whl
    django
    djangorestframework
    ```
- `python manage.py inspectdb` devuelve como quedarían los modelos [más info](https://books.agiliq.com/projects/django-orm-cookbook/en/latest/existing_database.html)
- `python manage.py inspectdb > models.py`
    ```js
    - Create model AppArray
    - Create model AppExam
    - Create model AppExamsSentences
    - Create model AppExamsUsers
    - Create model AppExamsUsersEvalh
    - Create model AppExamsUsersEvall
    - Create model AppSentence
    - Create model AppSentenceImages
    - Create model AppSentencesUsers
    - Create model AppSentenceTags
    - Create model AppSentenceTimes
    - Create model AppSentenceTr
    - Create model AppTag
    - Create model BaseLanguage
    - Create model BaseLanguageLang
    - Create model BaseUser
    - Create model BaseUserArray
    - Create model Template
    - Create model TemplateArray
    - Create model VersionDb
    ```
- `py manage.py makemigrations theapp` genera el fichero **theapp\migrations\0001_initial.py**
    - Es una clase tipo `class Migration(migrations.Migration):` con todos los modelos
- `py manage.py migrate` crea todas las tablas necesarias para el framework **auth y django**
    ```js
    System check identified some issues:

    WARNINGS:
    ?: (mysql.W002) MySQL Strict Mode is not set for database connection 'default'
    HINT: MySQL's Strict Mode fixes many data integrity problems in MySQL, such as data truncation 
    upon insertion, by escalating warnings into errors. It is strongly recommended you activate it. 
    See: https://docs.djangoproject.com/en/2.2/ref/databases/#mysql-sql-mode
    
    Operations to perform:
        Apply all migrations: admin, auth, contenttypes, sessions, theapp
    Running migrations:
        Applying contenttypes.0001_initial... OK
        Applying auth.0001_initial... OK
        Applying admin.0001_initial... OK
        Applying admin.0002_logentry_remove_auto_add... OK
        Applying admin.0003_logentry_add_action_flag_choices... OK
        Applying contenttypes.0002_remove_content_type_name... OK
        Applying auth.0002_alter_permission_name_max_length... OK
        Applying auth.0003_alter_user_email_max_length... OK
        Applying auth.0004_alter_user_username_opts... OK
        Applying auth.0005_alter_user_last_login_null... OK
        Applying auth.0006_require_contenttypes_0002... OK
        Applying auth.0007_alter_validators_add_error_messages... OK
        Applying auth.0008_alter_user_username_max_length... OK
        Applying auth.0009_alter_user_last_name_max_length... OK
        Applying auth.0010_alter_group_name_max_length... OK
        Applying auth.0011_update_proxy_permissions... OK
        Applying sessions.0001_initial... OK
        Applying theapp.0001_initial... OK
    ```
- registro los modelos en `\learnlang\theapp\admin.py`
- en `\apirest\learnlang\settings.py` registro **rest_framework** como aplicación en **INSTALLED_APPS**
- creo fichero `theapp\serializers.py` donde irán los traductores de objetos a json
- configurando `theapp/views.py` son las que gestionan el CRUD
- configuro las rutas: `learnlang/urls.py`
    ```py
    from django.conf import settings
    from django.conf.urls import url, include
    ```
    - **url(r'^api/', include('learnlang.theapp.urls')),** hace include de las rutas del módulo
- creo fichero de rutas de aplicación `learnlang\theapp\urls.py`
- ejecuto `py manage.py runserver`
    - ...y ...voila!! funciona!! ^^ no quepo de alegría
    - [`http://127.0.0.1:8000/api/`](http://127.0.0.1:8000/api/)

## Definiendo vistas customizadas 
- Nos permiten tener un mayor control del CRUD
- `from rest_framework.views import APIView, Response`
- Se define la vista en **theapp/views.py**
- Se define la ruta en **theapp/urls.py**
```py
urlpatterns = [
    url(r'customview', CustomView.as_view()),
]

urlpatterns += router.urls
```
- [`http://127.0.0.1:8000/api/customview`](http://127.0.0.1:8000/api/customview)
- La duda, de donde sale el método **as_view()** ??

## Instalando Swagger (documentación)
- `pipenv install --skip-lock django-rest-swagger`
- registro swagger en settings.py
- creo ruta de documentación en `theapp/urls.py`
    - `from rest_framework_swagger.views import get_swagger_view`
    - `schema_view = get_swagger_view(title='Pastebin API')`
    - `url(r'^docs/', schema_view)`
    - Funciona! [http://127.0.0.1:8000/api/docs/](http://127.0.0.1:8000/api/docs/)

# Customizando modelos
- Inserto mi módulo de utilidades
    - Creo carpeta y ficheros
    - lo registro en settings.py **INSTALLED_APPS**

- Para cambiar el comportamiento del modelo en el formulario del administrador hay que tocar el archivo **admin.py**
    - En este fichero se registran todos los modelos, pero no solo eso, tambien se excluyen y se reescriben.
    - si tengo un modelo por defecto, lo importo aqui y creo uno customizado para el administrador
    - algo como: `class AppArrayAdmin(admin.ModelAdmin):`
    - En el registro hago el mapeo `admin.site.register(AppArray,AppArrayAdmin)`

- Para customizar la visualización del crud de un modelo en el admin hay que configurar las siguientes tuplas en admin.py
    - list_display = (...campos...)
    - list_filter = (...campos...)
    - search_fields = (...campos...)

- He creado un modelo abstracto `class AbstractSysfields(models.Model):`
    - Todos los modelos deberán implementar esta clase
    - Esta, tiene definidos todos los campos de sistema

- [PDF - doccumentacion de django 2.2](https://buildmedia.readthedocs.org/media/pdf/django/2.2.x/django.pdf)
- [Doc Django - sobreescribir metodos save y delete](https://docs.djangoproject.com/en/2.2/ref/contrib/admin/#django.contrib.admin.ModelAdmin.save_model)

## [Python Valencia - Cómo hacer API Rest con Django](https://youtu.be/RoxEX9DFF7s)
#### [Repo Github](https://github.com/pythonvlc/intro-django-rest-framework)
- [Objeto Request](https://youtu.be/RoxEX9DFF7s?t=489)
    - **.data** - POST o FILES
    - **.query_params** - GET
    - **.user** - Django User (django.contrib.auth.models.User)
    - **.method** - "GET", "POST", "PUT" ...

- [Serializadores](https://youtu.be/RoxEX9DFF7s?t=575)
    - Se puede definir una serie de tipos Field (char,boolean, requerido, valor por defecto, etc)
    - **.is_valid()** - Valida los datos pasados. Estos son, los bindeados entre request y el serializador
    - **.save()** - Crea o Actualiza el objeto asociado
    - **ModelSerializer** - Igual que un ModelForm (que es un model form??? ^^)
    - **HyperlinkedModelSerializer** - Añade la url al detalle del recurso
    - **nota:** No es lo mismo un **serializer** que un **modelserializer**

- [Ejemplo](https://youtu.be/RoxEX9DFF7s?t=666)
```py
# Este es un SERIALIZER
class EventSerializer(serializers.Serializer):
    description = serializers.CharField(max_length=100)
    start = serializers.DateTimeField()
    finish = serializers.DateTimeField()

    # en data le llega los datos del request
    # se pueden definir validadores a nivel global (este de aqui) o de campo
    # para una validación por campo se haría: validate_description
    def validate(self, data):
        """
        Check that the start is before the stop.
        """
        if data["start"] > data["finish"]:
            # esto lanzará un error 400 al cliente
            raise serializers.ValidationError("finish must occur after start")
        return data

# Este es un MODELSERIALIZER
# https://youtu.be/RoxEX9DFF7s?t=727
class AccountSerializer(serializers.ModelSerializer):
    # Hace uso de una subclase Meta a la que se le inyecta un Modelo
    # en este ejemplo Account
    class Meta:
        model = Account
        # los campos que se desea mostrar
        fields = ("id","account_name","users","created")
        # campos que el cliente no puede tocar
        read_only_fields = ("account_name")

```
- [Views](https://youtu.be/RoxEX9DFF7s?t=767)
    - Django nos provee de muchos tipos de clases de tipo Vista. [Más info en cdrf.co](http://www.cdrf.co/)
    - APIView
    - ViewSet
    - ModelViewSet
    - ListCreateAPIView
    - RetrieveDestroyAPIView
    - Mixins
    - etc
- con APIView y ViewSet el control es mayor sobre el tratamiento de los datos
- [Ejemplos vistas](https://youtu.be/RoxEX9DFF7s?t=886)
```py
class UserViewSet(viewsets.ViewSet):
    """
    A simple ViewSet for listin or retrieving users.
    """
    def list(self,request):
        # select * from auth_user
        objqueryset = User.Objects.all()
        # many=True devuelve muchos usuarios en el json
        objserializer = UserSerializer(objqueryset, many=True)
        # por defecto la respuesta siempre es 200
        return Response(objserializer.data)

    def retrieve(self, request, pk=None):
        # devuelve todos los usuarios
        queryset = User.objects.all()
        # de esos usuarios obten el que tenga la pk que se ha pasado por la url
        user = get_object_or_404(queryset, pk=pk)
        serializer = UserSerializer(user)
        return Response(serializer.data)


class UserList(generics.ListCreateAPIView):
    oqueryset = User.objects.all()
    objserializer_class = UserSerializer
    permission_classes = (IsAdminUser,)
    # pagina de 100 en 100
    paginate_by = 100
```
- Todas las vistas al final tienen que devolver un **Response**

- [Response](https://youtu.be/RoxEX9DFF7s?t=975)
    - **.data** - Los datos serializados para la respuesta
    - **.status** - Código de estado de la respuesta

- [Routers](https://youtu.be/RoxEX9DFF7s?t=1002)
    - Conjuntamente con los ViewSets definidos previamente 
```py
router = routers.SimpleRouter()
# user como se llama el endpoint
# UserViewSet generará todas las variantes de los verbos
router.register(r'user', UserViewSet) 
router.register(r'accounts', AccountViewSet)

urlpatterns = [
    # tambien podemos tener urls típicas de django
    url(r'^forgot-password/$', ForgotPasswordFormView.as_view())
]

# se fusionan las urls de django con las del router
urlpatterns += router.urls
```
- [Registrar modelo](https://youtu.be/RoxEX9DFF7s?t=1332)
- Otra forma de registrar un modelo es con:
```py
# admin.py
@admin.register(MiModelo)
class MiModeloAdmin(admin.ModelAdmin):
    pass
```
- [archivos resources y serializers](https://youtu.be/RoxEX9DFF7s?t=1381)
    - Se crea carpeta **api**
    - dentro, dos ficheros: serializers y resources
    - resources: los viewsets, que para mi son los miapp.views
- [Serializador de tipo ModelSerializer](https://youtu.be/RoxEX9DFF7s?t=1410)
- [learnlang.urls configurando versiones de api](https://youtu.be/RoxEX9DFF7s?t=1480)
- [configuración del owner](https://youtu.be/RoxEX9DFF7s?t=1748)
    - En el viewset se sobreescribe el método **perfom_create**
    - Si revisamos lo que implementa el ModelViewSet, veremos que son 6 mixins que tienen que ver con las operaciones CRUD
    - El que nos interesa es el CreateModelMixin, que tiene el método
    - [video override](https://youtu.be/RoxEX9DFF7s?t=1789)
    ```py
    def perform_create(self, serializer):
        serializer.save()

    # override
    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)        
    ```
- [HyperlinkedModelSerializer](https://youtu.be/RoxEX9DFF7s?t=2055)
    - Esto hará que las foreign keys del modelo puedan servir un link con el endpoint del recurso foreing
    - Nos provee un campo **url** que añadido al atributo (tupla) fields autogenera el endpoint
    ```py
    class TodoSerializer(serializers.ModelSerializer):
    # ahora sería 
    class TodoSerializer(serializers.HyperlinkedModelSerializer):
        model = Todo
        fields = ("Text","due_date","url")
    ```
- [Permissions](https://youtu.be/RoxEX9DFF7s?t=2265)
    - Permiso de acceso a los endpoints como a los objetos 
    - Creamos un fichero **api\permissions.py** en el creamos clases con nombres de permisos.
    - Ejemplo
        - 
        - 
    - En los resources (mis views.py) importamos los permisos
    - En el atributo ModelViewSet.permission_classes (una tupla) asignamos (IsAuthenticated, IsOwnerOrDeny)
    - En [settings.py](https://youtu.be/RoxEX9DFF7s?t=2286) hay un atributo:
        - `REST_FRAMEWORK["DEFAULT_PERMISSION_CLASSES"]="rest_framework.permissions.IsAuthenticated"`
        - Indica que, con que estes autenticado ya tienes acceso a todo
    - Forma de renderizar los datos [DEFAULT_RENDERER_CLASSES](https://youtu.be/RoxEX9DFF7s?t=2324)
    ```py
    # permissions.py
    from rest_framework.permissions import BasePermission

    class IsOwnerOrDeny(BasePermission):
        def has_object_permission(self, request, view, obj):
            return request.user == obj.owner

    # resources.py
    from rest_framework.permissions import IsAuthenticated
    from .serializers import TodoSerializer #HyperlinkedModelSerializer
    from .permissions import IsOwnerOrDeny 

    class TodoViewSet(viewsets.ModelViewSet):
        queryset = Todo.objects.all()
        serializer_class = TodoSerializer
        permission_classes = (IsAuthenticated, IsOwnerOrDeny)

        def perform_create(self, serializer):
            serializer.save(owner=self.request.user)

    ```
- [Filtrar el los recursos por el usuario en sesion](https://youtu.be/RoxEX9DFF7s?t=2617)
    ```py
    class TodoViewSet(viewsets.ModelViewSet):
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer
    permission_classes = (IsAuthenticated, IsOwnerOrDeny)

    # https://youtu.be/RoxEX9DFF7s?t=2633
    def get_queryset(self):
        # self.request.user habria que hacerlo en un "Manager de Django"
        return self.queryset.filter(owner=self.request.user)

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)
    ```
- [Marcar la tarea como hecha, un endpoit que se sale del patrón](https://youtu.be/RoxEX9DFF7s?t=2762)
    ```py
    # models.py
    class Todo(models.Model):
        owner = ...
        ..
        done = models.BooleanField(Blank=True, null=False, default=False)
        def mark_as_done(self):
            self.done = True
            self.save()

        def __str__(self)...

    # resources.py
    # se crea otra clase
    # Los viewset no proveen de metodos: list ni retrieve (detail)
    class TodoDoneViewSet(viewsets.ViewSet):
        # el método lo generamos aqui y lo registramos más abajo
        def done(self, request, *args, **kwargs):
            pk = kwargs.get("pk",0)
            todo = get_object_or_404(Todo, pk=pk)
            todo.mark_as_done()
            return Response(status=status.HTTP_204_NO_CONTENT)

    # registra el viewset con el verbo:viewset.metodo
    donerouter = TodoDoneViewSet.as_view({"patch":"done"})
    
    # en theapp/urls.py
    router = SimpleRouter()
    router.register(r'todos', viewset=TodoViewSet)

    # como no es un endpoint al uso, no se puede usar el SimpleRouter()
    # hay que incluirlo en una url separada
    urlpatterns = patterns(
        "",
        url(r"",include(router.urls)),
        url(r"^todos/(?P<pk>[^/.]+)/done/$",donerouter, name="todo-done")
    )
    ```
    [configurando el enrutador con done](https://youtu.be/RoxEX9DFF7s?t=2883)


> **Default Router** This router is similar to SimpleRouter, but additionally includes a default API root view, that returns a response containing hyperlinks to all the list views. It also generates routes for optional .json style format suffixes.

[Paginación](https://youtu.be/RoxEX9DFF7s?t=3340)
- En la respuesta GET aparece:
    - count: los items que hay
    - next: la url de la sig página
    - previous: la url de la previa
    - results: array de resultado

[Tests](https://youtu.be/RoxEX9DFF7s?t=3448)
- Django ofrece la clase APITestCase y metodos para hacer pruebas sobre la API
    ```py
    from rest_framework.test import APITestCase
    class TestApi(APITestCase):
        ....
    ```

[Tipos de autenticaciones](https://youtu.be/RoxEX9DFF7s?t=3668)
    - BasicAuthentication para uso con curl
    - CustomAuthentication, la del ejemplo
    - [TokenAuthentication](https://youtu.be/RoxEX9DFF7s?t=3692)
        - Hay que crear la url de identificacion

[Throttling](https://youtu.be/RoxEX9DFF7s?t=3918)
    - Limite de peticiones por segundo

[Filtrados](https://youtu.be/RoxEX9DFF7s?t=3928)
    - Se pueden usar los filtros del django admin

[Excepciones](https://youtu.be/RoxEX9DFF7s?t=3977)
    - Se puede devolver distintos tipos de excepciones

[Estructura del proyecto](https://youtu.be/RoxEX9DFF7s?t=4099)

[Un api root](https://youtu.be/RoxEX9DFF7s?t=4133)
    - Listado de todas las acciones que puede hacer un usuario

[response.py](https://youtu.be/RoxEX9DFF7s?t=4145)
    - [Ejemplo AcceptJobViewSet(ViewSet)](https://youtu.be/RoxEX9DFF7s?t=4187)

```js
    settings.py
    models.py
    utils\utils.py
    admin.py
    settings.py
    models.py
    utils\utils.py
    admin.py
    main-urls.py
    app urls.py
    views.py
    serializers.py
```

- [Django doc - model](https://docs.djangoproject.com/en/2.2/_modules/django/db/models/base/#Model)
- [Django doc - override serializers](https://www.django-rest-framework.org/api-guide/serializers)
- [Django doc - serializers.py source code](https://github.com/encode/django-rest-framework/blob/master/rest_framework/serializers.py)
- [Rest fw cdrf.co ModelSerializer methods](http://www.cdrf.co/3.1/rest_framework.serializers/ModelSerializer.html)

- [Django doc - override ViewSet actions](https://www.django-rest-framework.org/api-guide/viewsets/#viewset-actions)
- [Django doc - viewsets.py source code](https://github.com/encode/django-rest-framework/blob/master/rest_framework/viewsets.py)
- [Rest fw cdrf.co ModelViewSet methods](http://www.cdrf.co/3.1/rest_framework.viewsets/ModelViewSet.html)

# [Refactorizando el proyecto - su estructura](https://www.revsys.com/tidbits/recommended-django-project-layout/)
- Usando los settings en distintos entornos:
```sh
export DJANGO_SETTINGS_MODULE=“foo.settings.jenkins”
or
./manage.py migrate —settings=foo.settings.production
or using gunicorn:
gunicorn -w 4 -b 127.0.0.1:8001 —settings=foo.settings.dev
```
- Ejecutar **runserver**:
    - `py manage.py runserver --settings=learnlang.settings.dev`