# flask: libreria para servidor web
from flask import Flask

# __name__ nombre del módulo
app = Flask(__name__)

# en que url vamos a ejecutar esta función
@app.route('/')

# definiendo función
def hello_world():
    return 'Hola mundo'

if __name__ == '__main__':
    app.run()

#run
#python main.py

"""
ImportError: cannot import name 'flask' from 'flask' (E:\programas\python\python37-32\lib\site-packages\flask\__init__.py)
es from Flask y no from flask
"""