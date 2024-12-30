https://github.com/eacevedof/prj_python37/tree/master/ia-langchain

### errores:
```sh
# esta libreria ayuda interpretar el html y volcarlo en un objeto
bshtml_loader = BSHTMLLoader(path)
                ^^^^^^^^^^^^^^^^^^
File "be-api\venv\Lib\site-packages\langchain_community\document_loaders\html_bs.py", line 102, in __init__
raise ImportError(
ImportError: beautifulsoup4 package not found, please install it with `pip install beautifulsoup4` 

File "be-api\venv\Lib\site-packages\langchain_community\document_loaders\html_bs.py", line 111, in __init__
  raise ImportError(
ImportError: By default BSHTMLLoader uses the 'lxml' package. Please either install it with 
`pip install -U lxml` or pass in init arg `bs_kwargs={'features': '...'}

File "C:\projects\prj_python37\wa-chatgpt\be-api\venv\Lib\site-packages\langchain_community\document_loaders\pdf.py", line 238, in __init__
raise ImportError(
ImportError: pypdf package not found, please install it with `pip install pypdf`
```