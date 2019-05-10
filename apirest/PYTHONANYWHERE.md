# so
```js
(<my-env>) 17:39 ~ $ cat /etc/os-release
NAME="Ubuntu"
VERSION="16.04.5 LTS (Xenial Xerus)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 16.04.5 LTS"
VERSION_ID="16.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=xenial
UBUNTU_CODENAME=xenial
```

# Pasos

- hacer git clone
- ejecutar `mkvirtualenv --python=/usr/bin/python3.7 <my-env>`
    ```
    17:33 ~ $ mkvirtualenv --python=/usr/bin/python3.7 <my-env>
    Running virtualenv with interpreter /usr/bin/python3.7
    Using base prefix '/usr'
    /usr/local/lib/python2.7/dist-packages/virtualenv.py:1041: DeprecationWarning: 
    the imp module is deprecated in favour of importlib; 
    see the module's documentation for alternative uses
    import imp
    New python executable in /home/<myaccount>/.virtualenvs/<my-env>/bin/python3.7
    Also creating executable in /home/<myaccount>/.virtualenvs/<my-env>/bin/python
    Installing setuptools, pip, wheel...done.
    virtualenvwrapper.user_scripts creating /home/<myaccount>/.virtualenvs/<my-env>/bin/predeactivate
    virtualenvwrapper.user_scripts creating /home/<myaccount>/.virtualenvs/<my-env>/bin/postdeactivate
    virtualenvwrapper.user_scripts creating /home/<myaccount>/.virtualenvs/<my-env>/bin/preactivate
    virtualenvwrapper.user_scripts creating /home/<myaccount>/.virtualenvs/<my-env>/bin/postactivate
    virtualenvwrapper.user_scripts creating /home/<myaccount>/.virtualenvs/<my-env>/bin/get_env_details    
    ```
    - **the imp module is deprecated in favour of importlib; **
        - No encontré nada para esta advertencia

- pip install django
- pip install django-debug-toolbar
- pip install djangorestframework
- pip install django-rest-swagger
- pip install mysqlclient
```js
(venv1) 18:11 ~ $ pip freeze
-f /usr/share/pip-wheels
certifi==2019.3.9
chardet==3.0.4
coreapi==2.3.3
coreschema==0.0.4
Django==2.2.1
django-debug-toolbar==1.11
django-rest-swagger==2.2.0
djangorestframework==3.9.3
Glances==3.1.0
idna==2.8
itypes==1.1.0
Jinja2==2.10.1
MarkupSafe==1.1.1
mysqlclient==1.4.2.post1
openapi-codec==1.3.2
psutil==5.6.2
pytz==2019.1
requests==2.21.0
simplejson==3.16.0
sqlparse==0.3.0
uritemplate==3.0.0
urllib3==1.24.3
```
