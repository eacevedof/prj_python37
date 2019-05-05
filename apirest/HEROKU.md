## [Youtube video - Django application Deployment on Heroku in Windows](https://www.youtube.com/watch?v=2kvTsCskJA0)

#### [This original content](https://www.dropbox.com/s/68sc3ihna7qdaiu/test.py?dl=0)

> Author : Shubham Aggarwal <br/>
> Github username : shuboy2014 <br/>
> Email : shubham.aggarwal2020@gmail.com <br/>
 
1. Setup django project name it **<your-project-name>** with application **<application-name>** 
- In mycase it is myproject with  application myapp 
 
2. Run command in cmd :
```js
#{start   
pip install dj-database-url gunicorn psycopg2 whitenoise
#  end}
```

3. Run command in cmd (cmd in directory where **manage.py** file) :
```js
#{start   
pip freeze > **requirements.txt**
#  end}
```

4. Create file **Procfile** and add content :
```js
#{start
    web: gunicorn <your_project_name>.wsgi
#end}     
```
 
5. Create file **runtime.txt** file and add below content : 
```js
#{start
    <your complete version of python in mycase "python-2.7.12" >
#end}
```

6. In myproject/**settings.py** file add below content :
```js
#{start
    import dj_database_url
    db_from_env = dj_database_url.config(conn_max_age=500)
    DATABASES['default'].update(db_from_env)
#  end}
```    

7. In **wsgi.py** file add below content :
```js
#{start
    from whitenoise.django import DjangoWhiteNoise
    application = DjangoWhiteNoise(application)
#end} 
```
        
8. In **settings.py** file add below content :
```js
#{start
    STATIC_URL = '/static/'
    STATICFILES_DIRS = [
            os.path.join(BASE_DIR, "static"),
        ]
    STATIC_ROOT = os.path.join(BASE_DIR, "staticfiles")
    STATICFILES_STORAGE = 'whitenoise.django.GzipManifestStaticFilesStorage'
#end}
```
 
9. Create folder name "static" in where manage.py directory 
    - place your all static files in "static/" folder
    - if you have not any static file then add empty file in "static/" folder name it anything that you want (let say ".keep") so that git track it otherwise you will get error while deploying :)

10. commit the myproject directory (git must be installed in your PC):
    - Run commands in myproject directory :
    ```js
    #{start
    git init
    git add .
    git status
    git commit -m "initial commit"
    #end}
    ```
 
11. login in heroku(heroku toolblet must be installed in your PC):
    - Run commands in myproject directory :
    ```js
    #{start
    heroku login
    heroku create <your website name(let say we take "shuboy2020")>
    git push heroku master
    heroku open
    #end}
    ```

>Thanks for watching guys , if you have any suggestion or feedback please comment below !<br/>
>If you have database then run in terminal/cmd

12. **makemigrations** and migrate command
```js
#{start
heroku run python manage.py makemigrations
heroku run python manage.py migrate
#end}
```