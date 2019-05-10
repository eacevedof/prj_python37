# Pasos
- hacer git clone
- ejecutar `mkvirtualenv --python=/usr/bin/python3.7 myenv`
    ```
    17:33 ~ $ mkvirtualenv --python=/usr/bin/python3.7 venv1
    Running virtualenv with interpreter /usr/bin/python3.7
    Using base prefix '/usr'
    /usr/local/lib/python2.7/dist-packages/virtualenv.py:1041: DeprecationWarning: 
    the imp module is deprecated in favour of importlib; 
    see the module's documentation for alternative uses
    import imp
    New python executable in /home/<myaccount>/.virtualenvs/venv1/bin/python3.7
    Also creating executable in /home/<myaccount>/.virtualenvs/venv1/bin/python
    Installing setuptools, pip, wheel...done.
    virtualenvwrapper.user_scripts creating /home/<myaccount>/.virtualenvs/venv1/bin/predeactivate
    virtualenvwrapper.user_scripts creating /home/<myaccount>/.virtualenvs/venv1/bin/postdeactivate
    virtualenvwrapper.user_scripts creating /home/<myaccount>/.virtualenvs/venv1/bin/preactivate
    virtualenvwrapper.user_scripts creating /home/<myaccount>/.virtualenvs/venv1/bin/postactivate
    virtualenvwrapper.user_scripts creating /home/<myaccount>/.virtualenvs/venv1/bin/get_env_details    
    ```
    - **the imp module is deprecated in favour of importlib; **
        - No encontré nada para esta advertencia
    ```js
    (venv1) 17:39 ~ $ cat /etc/os-release
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
    