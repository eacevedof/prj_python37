## [Youtube Python Django Tutorial: Deploying Your Application (Option #2) - Deploy using Heroku](https://youtu.be/6DI_7Zja8Zc?t=744)
> By Corey Schafer - Publicado el 19 feb. 2019

#### commands:
- `heroku login`
- `heroku create prj-apirest --buildpack heroku/python`
    - `heroku apps:delete --app tfw-firstapp`
- `heroku open -a <appname>`
    - [https://prj-apirest.herokuapp.com/](https://prj-apirest.herokuapp.com/)

- `heroku git:remote -a prj-apirest`
- `git push heroku master` 
    - **error:**
    ```sh
    remote: Compressing source files... done.
    remote: Building source:
    remote:
    remote: -----> App not compatible with buildpack: https://buildpack-registry.s3.amazonaws.com/buildpacks/heroku/python.tgz
    remote:        More info: https://devcenter.heroku.com/articles/buildpacks#detection-failure
    remote:
    remote:  !     Push failed
    remote: Verifying deploy...
    remote:
    remote: !       Push rejected to prj-apirest.
    remote:
    To https://git.heroku.com/prj-apirest.git
    ! [remote rejected] master -> master (pre-receive hook declined)
    error: failed to push some refs to 'https://git.heroku.com/prj-apirest.git'    
    ```
- `git subtree push --prefix apirest heroku master`
    - Despues del error anterior pruebo este comando
    - Define un subdirectorio como un subrepo
    - **error**
    ```sh
    remote: Compressing source files... done.
    remote: Building source:
    remote:
    remote: -----> Python app detected
    remote:  !     No 'Pipfile.lock' found! We recommend you commit this into your repository.
    remote: -----> Installing python-3.6.8
    remote: -----> Installing pip
    remote: -----> Installing dependencies with Pipenv 2018.5.18…
    remote:        Installing dependencies from Pipfile…
    remote:        An error occurred while installing https://download.lfd.uci.edu/pythonlibs/u2hcgva4/mysqlclient-1.4.2-cp37-cp37m-win32.whl#egg=mysqlclient! Will try again.
    remote:        An error occurred while installing django! Will try again.
    remote:        Installing initially–failed dependencies…
    remote:
    remote:        mysqlclient-1.4.2-cp37-cp37m-win32.whl is not a supported wheel on this platform.
    remote:        You are using pip version 9.0.2, however version 19.1 is available.
    remote:        You should consider upgrading via the 'pip install --upgrade pip' command.
    remote:
    remote:  !     Push rejected, failed to compile Python app.
    remote:
    remote:  !     Push failed
    remote: Verifying deploy...
    remote:
    remote: !       Push rejected to prj-apirest.
    remote:
    To https://git.heroku.com/prj-apirest.git
    ! [remote rejected] b0a7ae04754f32c80f3ea3954fede5abbb5e223a -> master (pre-receive hook declined)
    error: failed to push some refs to 'https://git.heroku.com/prj-apirest.git'    
    ```
    - **más errores:**
    - Este ocurre porque no es capaz de ejecutar **settings/prod.py** una vez hecho el push
    ```
    remote: File "/app/.heroku/python/lib/python3.6/site-packages/django/conf/__init__.py", line 66, in _setup 
    remote: self._wrapped = Settings(settings_module) 
    remote: File "/app/.heroku/python/lib/python3.6/site-packages/django/conf/__init__.py", line 176, in __init__ 
    remote: raise ImproperlyConfigured("The SECRET_KEY setting must not be empty.") 
    remote: django.core.exceptions.ImproperlyConfigured: The SECRET_KEY setting must not be empty. 
    remote: 
    remote: ! Error while running '$ python manage.py collectstatic --noinput'. 
    remote: See traceback above for details. 
    remote: 
    remote: You may need to update application code to resolve this error. 
    remote: Or, you can disable collectstatic for this application: 
    remote: 
    remote: $ heroku config:set DISABLE_COLLECTSTATIC=1
    ```
- Sigue dando errores y al parecer hay que instalar otros programas **unicorn** y **whitenoise** tampoco es compatible con la distribución (dirtree) que tengo.
- Más info: [https://developer.mozilla.org/es/docs/Learn/Server-side/Django/Deployment](https://developer.mozilla.org/es/docs/Learn/Server-side/Django/Deployment)
- Lo dejo a medias... :s. Tiene que haber otra forma más sencilla de desplegar **Django**
- He instalado unicorn y whitenoise y lo he configurado
- He corregido algunos errores de staticfiles
- He corregido la importación en **wsgi.py**
- Funciona, pero, va con **Postgress** y no se como lanzar la migración :) sorpresas ~~!




