### windows

```
cd learn-langs
python -m venv .venv-win
.venv-win\Scripts\activate
.venv-win\Scripts\python.exe -m pip install --upgrade pip
.venv-win\Scripts\python.exe -m pip install -r .\requirements.txt
```

### linux
```
cd $PROJECT_DIR/prj_python37/learn-langs
python3 -m venv ./.venv-wsl
source ./.venv-wsl/bin/activate

.venv-wsl/bin/python -m pip install --upgrade pip
.venv-wsl/bin/python -m pip install -r requirements.txt
```