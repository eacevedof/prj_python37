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

- pipinstall django
