# Platzigram

## [Parte 4 - Clases Django](https://platzi.com/clases/django/) 

##### Video 3 Preparación del entorno de trabajo
- Entornos virtuales 
- `python -m venv .env`  Crea la carpeta con el entorno virtual
- <details>
	<summary>.env (tree en windows)</summary>
    <p>
    
    ```
    D:.
    ├───Include
    ├───Lib
    │   ├───site-packages
    │   │   ├───pip
    │   │   │   ├───_internal
    │   │   │   │   ├───commands
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───models
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───operations
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───req
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───utils
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───vcs
    │   │   │   │   │   └───__pycache__
    │   │   │   │   └───__pycache__
    │   │   │   ├───_vendor
    │   │   │   │   ├───cachecontrol
    │   │   │   │   │   ├───caches
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───certifi
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───chardet
    │   │   │   │   │   ├───cli
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───colorama
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───distlib
    │   │   │   │   │   ├───_backport
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───html5lib
    │   │   │   │   │   ├───filters
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   ├───treeadapters
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   ├───treebuilders
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   ├───treewalkers
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   ├───_trie
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───idna
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───lockfile
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───msgpack
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───packaging
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───pkg_resources
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───progress
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───pytoml
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───requests
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───urllib3
    │   │   │   │   │   ├───contrib
    │   │   │   │   │   │   ├───_securetransport
    │   │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   ├───packages
    │   │   │   │   │   │   ├───backports
    │   │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   │   ├───ssl_match_hostname
    │   │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   ├───util
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───webencodings
    │   │   │   │   │   └───__pycache__
    │   │   │   │   └───__pycache__
    │   │   │   └───__pycache__
    │   │   ├───pip-10.0.1.dist-info
    │   │   ├───pkg_resources
    │   │   │   ├───extern
    │   │   │   │   └───__pycache__
    │   │   │   ├───_vendor
    │   │   │   │   ├───packaging
    │   │   │   │   │   └───__pycache__
    │   │   │   │   └───__pycache__
    │   │   │   └───__pycache__
    │   │   ├───setuptools
    │   │   │   ├───command
    │   │   │   │   └───__pycache__
    │   │   │   ├───extern
    │   │   │   │   └───__pycache__
    │   │   │   ├───_vendor
    │   │   │   │   ├───packaging
    │   │   │   │   │   └───__pycache__
    │   │   │   │   └───__pycache__
    │   │   │   └───__pycache__
    │   │   ├───setuptools-39.0.1.dist-info
    │   │   └───__pycache__
    │   └───tcl8.6
    └───Scripts    
    ```
    
    </p>
</details>
- `source .env/scripts/`
- 