
### [Redes neuronales - Cómo Aprenden](https://www.youtube.com/watch?v=CU24iC3grq8)
- Neurona. Proceso de **activación** y **disparo**. Disparo que activa otra neurona. Análogo a una entrada/salida
- En el proceso de práctica de una habilidad (hacer malabares p.e) esto genera conexiones entre neuronas que no tienen relación ninguna
de modo que la activacion en la primera hace que la última se dispare instantaneamente
- [como se emularia este proceso en 0 y 1](https://youtu.be/CU24iC3grq8?t=201)
- Que influye en la toma de una decisión?
  - Tomemos como ejemplo la planificación de un viaje con estas tres preguntas:
  - Tienes dinero suficiente?  => x1
  - Tu pareja quiere ir? => x2
  - El lugar tiene clima agradable? => x3
- Asumamos estos factores como x1, x2 y x3
  - Cada factor tiene dos opciones opsibles si/no  1/0
- Si entendemos estos estados como entradas de una **función X** podriamos asumir que según unos valores esperemos un retorno
- las posibles entradas serían 2^3 = 8.  (cantidad de valores posibles en las entradas) ^ (numero de entradas)
- Tomemos el caso: x1=0, x2=0 y x3=0 la salida esperada 0
- [Como deberia ser esta **función** para que retorne 0?](https://youtu.be/CU24iC3grq8?t=297)
- Definamos un **umbral** de decisión (un número arbitrario) en este caso 1
- Si suma(xi)>1 => 1 si no 0 `s => suma(xi)>1`
- Con esta toma de decisión así no haya dinero deberias irte de viaje.
- Corrijamos el resultado. Agregemos una **importancia** o **peso** a x1.  Sin dinero no vamos de viaje.
- `s => suma(x1*2, x2*1, x3*1) > 2`
- Esta función ya no es tan simple. A este tipo de funcones la podemos identificar como: [**perceptron**](https://youtu.be/CU24iC3grq8?t=451)
- Un **perceptrón** (**neurona**) consta de:
  - **Factores o entradas**
  - **Peso de cada entrada**
  - **Función de activación** `s => suma(x1*2, x2*1, x3*1) > 2`
  - **Umbral** (Realmente se usa el **sesgo**, que es la inverda del umbral)
- Si este perceptron recibe una entrada de n factores que a su vez son resultados de la toma de decisión de otros perceptrones
- Así se podria formar un [**perceptrón multicapa**](https://youtu.be/CU24iC3grq8?t=510) los perceptrones multicapa reciben el nombre
de [**red neuronal**](https://youtu.be/CU24iC3grq8?t=516)
- Con un solo **perceptrón** pudimos tomar una decisión interesante si contamos con una red de estos perceptrones podriamos tomar decisiones más complejas.
- [Red neuronal que debe entender una imagen](https://youtu.be/CU24iC3grq8?t=555)
- El **peso** y **umbral** son perillas ajustables permitiendo así optimizar la salida esperada
- Una red neuronal consta de millones de neuronas 
- Los ajustes de estas perillas podrían desencadenar en una salida no esperada ya que al ser millones no es factible controlar todas estas I/O. 
Por lo tanto, lo interesante sería que la neurona no tome la decisión como tal (1/0) si no que **sugiera** en que porcentaje entre **0 y 1**
es adecuada una salida.  En lugar de una función [**escalón o step function**](https://youtu.be/_0wdproot34?t=283) se usa una sigmoide
- [De esta manera](https://youtu.be/CU24iC3grq8?t=674), al cambiar un (peso/umbral) la salida y su impacto en las otras neuronas esta mejor controlado

### [Funciones de activación](https://www.youtube.com/watch?v=_0wdproot34&t=637s)
- `(entrada*peso + netrada*peso ...) comparado con el sesgo`
- Una red neuronal sin funcion de activación es muy limitada
- Algunas funciones:
  - step function
  - no es lineal pero no es apta para el aprendizaje que necesitamos
- En el proceso de entrenamiento tras varios intentos comprobamos los resultados y los procesamos con al [función de costo](https://youtu.be/_0wdproot34?t=326)
para ver que tan bien estuvo la red en las predicciones.
- Dependiendo que tan mal le fue habrá que ajustar los **pesos** y **sesgos**. Para hacer esto debemos 
- `calcular la derivada gradiente de la función de costo respecto a cada uno de los pesos y sesgos` esto se hace capa por capa hacia atras llegando al inicio.
- Este proceso se llama [**propagación hacia atras**](https://youtu.be/_0wdproot34?t=341)
- Siguiendo esta premisa la función **step** no tiene derivada o siempre es 0 con lo cual no permitiria un ajuste. 
- Esto nos obliga a que las funciones de activación sean **diferenciables** [Video derivadas](https://www.youtube.com/watch?v=njoOd9iV2Qo)
- Funciones **sigmoides** (porque tienen forma de S)
  - [Función logistica](https://youtu.be/_0wdproot34?t=412) tambien se le conoce como función sigmoide a secas.
    - Acotada en y entre 0 y 2
    - Esta función es diferenciable ya que tiene una curva. No es lo mismo la y de x1 que de x2. Hay una variación (dY)
    - [su formula: 1/(1 + e^-x)](https://youtu.be/_0wdproot34?t=442)
    - la y de esta función se mueve entre 0 y 1. Si una imagen es un perro o un gato. Esta función es perfecta.
    - si le damos entradas muy grandes o muy pequeñas la derivada se hace muy pequeña esto implica que en la propagación hacia 
    atrás los ajustes de los pesos y sesgos en la red seran tambien minimos y esto hará que las capas iniciales dejen de aprender
    - Esto se llama el **desvanecimiento de la gradiente** la derivada se vuelve muy pequeña conforme se avanza en la **propagación hacia atrás**
  - [Tangente Hiperbolica - TANH](https://youtu.be/_0wdproot34?t=554)
    - Similar a la logistica. Acotada en y entre -1 y 1
    - [su formula: (e^x - e^-x)/(e^x + e^-X)](https://youtu.be/_0wdproot34?t=561)
    - Esta derivada es mayor a la anterior. Buscamos que estas sean suficientemente grandes para que los ajustes en la red neuronal 
    sean sustanciales de modo que aprenda más rápido.
    - 


### Instalando tensorflow
- instalación de miniconda
  - **Miniconda**: version light de Anaconda. Anaconda plataforma de ciencia de datos de codigo abierto. Con miniconda se pueden crar projectos
  aislados por entornos.
- `curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -o Miniconda3-latest-MacOSX-x86_64.sh`
- `bash Miniconda3-latest-MacOSX-x86_64.sh`
```
hay que configurar la variable de entorno PYTHONPATH
If you'd prefer that conda's base environment not be activated on startup, 
   set the auto_activate_base parameter to false: 
conda config --set auto_activate_base false
```
- `pip install tensorflow`
- Esto tarda como 20 minutos
```
Installing collected packages: 
tensorboard-plugin-wit,
pyasn1,
libclang,
flatbuffers,
wrapt,
urllib3,
typing-extensions,
termcolor,
tensorflow-io-gcs-filesystem,
tensorflow-estimator,
tensorboard-data-server,
six,
rsa,
pyasn1-modules,
protobuf,
packaging,
oauthlib,
numpy,
MarkupSafe,
markdown,
keras,
idna,
grpcio,
gast,
charset-normalizer,
certifi,
cachetools,
absl-py,
werkzeug,
scipy,
requests,
opt-einsum,
ml-dtypes,
h5py,
google-pasta,
google-auth,
astunparse,
requests-oauthlib,
jax,
google-auth-oauthlib,
tensorboard,
tensorflow

Successfully installed
  MarkupSafe-2.1.2
  absl-py-1.4.0
  astunparse-1.6.3
  cachetools-5.3.0
  certifi-2022.12.7
  charset-normalizer-3.1.0
  flatbuffers-23.3.3
  gast-0.4.0
  google-auth-2.17.1
  google-auth-oauthlib-0.4.6
  google-pasta-0.2.0
  grpcio-1.53.0
  h5py-3.8.0
  idna-3.4
  jax-0.4.8
  keras-2.12.0
  libclang-16.0.0
  markdown-3.4.3
  ml-dtypes-0.0.4
  numpy-1.23.5
  oauthlib-3.2.2
  opt-einsum-3.3.0
  packaging-23.0
  protobuf-4.22.1
  pyasn1-0.4.8
  pyasn1-modules-0.2.8
  requests-2.28.2
  requests-oauthlib-1.3.1
  rsa-4.9
  scipy-1.10.1
  six-1.16.0
  tensorboard-2.12.0
  tensorboard-data-server-0.7.0
  tensorboard-plugin-wit-1.8.1
  tensorflow-2.12.0
  tensorflow-estimator-2.12.0
  tensorflow-io-gcs-filesystem-0.32.0
  termcolor-2.2.0
  typing-extensions-4.5.0
  urllib3-1.26.15
  werkzeug-2.2.3
  wrapt-1.14.1
```
