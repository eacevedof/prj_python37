
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
    - Acotada en y entre 0 y 1
    - Esta función es diferenciable ya que tiene una curva. No es lo mismo la y de x1 que de x2. Hay una variación (dY)
    - [su formula: 1/(1 + e^-x)](https://youtu.be/_0wdproot34?t=442)
    - la y de esta función se mueve entre 0 y 1. Si una imagen es un perro o un gato. Esta función es perfecta.
    - si le damos entradas muy grandes o muy pequeñas la derivada se hace muy pequeña esto implica que en la propagación hacia 
    atrás los ajustes de los pesos y sesgos en la red seran tambien minimos y esto hará que las capas iniciales dejen de aprender
    - Esto se llama el **desvanecimiento de la gradiente** la derivada se vuelve muy pequeña conforme se avanza en la **propagación hacia atrás**
    - es cara de calcular por que lleva exponente
  - [Tangente Hiperbolica - TANH](https://youtu.be/_0wdproot34?t=554)
    - Similar a la logistica. Acotada en y entre -1 y 1
    - [su formula: (e^x - e^-x)/(e^x + e^-X)](https://youtu.be/_0wdproot34?t=561)
    - Esta derivada es mayor a la anterior. Buscamos que estas sean suficientemente grandes para que los ajustes en la red neuronal 
    sean sustanciales de modo que aprenda más rápido.
    - Otro punto importante es que está centrada en el 0
    - La anterior (logistica) solo permite trabajar con + o - en cada capa. No deja mezclar. lo que limita la velocidad de aprendizaje
    - La hiperbolica permite mezclar + y -
    - tambien tiene el problema de **desvanecimiento del gradiente**
    - es cara de calcular por que lleva exponentes
  - [softsign](https://youtu.be/_0wdproot34?t=657)
    - Tiene mejor gradiente pero su derivada es más compleja y comparte algunos inconvenientes
  - [ReLU Rectified Linear Unit](https://youtu.be/_0wdproot34?t=672)
    - [su fórmula: max(0, x)](https://youtu.be/_0wdproot34?t=713) 
    - si x<0 => 0 sino x
    - Esta era mucho mejor que las anteriores en la mayoria de los casos
    - La propagación hacia adelante y atras era hasta seis veces más rapida que la *tangente hiperbólica*
    - Se usó para AlexNet en 2012
    - En 2018 fue la más usada
    - Lo especial de ReLU ante las otras:
      - La formula es muy simple
      - [Su gráfica](https://youtu.be/_0wdproot34?t=726) nos permite ver que tiene un coste computacional muy bajo
      - Su derivada también es muy simple. 0 para todos los x negativos y 1 para todos los positivos
      - La derivada en 0 no existe. Pero es tan raro tener un 0 absoluto que se puede despreciar y usar 0 o 1
      - Relu no está acotada pra numeros positivos con lo cual da una gradiente constante y genera un aprendizaje más rápido
    - Inconvenientes
      - Como regresa 0 para todos los numeros negativos va a degenerar en las llamadas neuronas muertas que durante el entrenamiento
      solo devolverán 0 entorpeciendo el aprendizaje. Esto sucede especialmente en tasas de aprendizajes muy grandes donde es más probable
      que caigamos en números negativos pasando las neuronas a 0 y que ya no se puedan recuperar.
  - [Leaky ReLU](https://youtu.be/_0wdproot34?t=819)
    - **su fórmula: max(0.01x, x)**
    - Similar a la anterior pero para x<0 f(x) tiende a -0.01 pero nunca lo es.
    - No acotada, simple de calcular y evita las neuronas muertas pero como la derivada en números negativos es pequeña es propensa
    al desvanecimiento del gradiente.
  - [Parametric ReLu - Relu Parametrizable](https://youtu.be/_0wdproot34?t=844) 
    - **su fórmula: ax if x>0** a es el parámetrizable. Por ejemplo a=0.1
  - [Parametric GeLu](https://youtu.be/_0wdproot34?t=844)
    - Caracterisctica muy importante. No es **monótona** (solo creciente o decreciente) Incrementan o decrementan constantemente y pasan
    solo una vez por el 0.
    - Una que no lo es puede crear montes y valles e incluso pasar dos veces o más por el 0
    - Esto posibilita que algunas funciones basadas en Gelu puedan hacer que las redes neuronales sean tan eficientes como las cerebrales
    - Es utilizada por la función [BERT](https://cloud.google.com/ai-platform/training/docs/algorithms/bert-start?hl=es-419), [GPT](https://chat.openai.com/)
  - [Softplus](https://youtu.be/_0wdproot34?t=896)
    - **fórmula: ln(1 + e^x)**
    - Una versión suave de ReLU
    - Un dato interesante es que su derivada es la función logística
    - Da mejores resultados que ReLU pero su costo computacional es mayor
    - Aunque tiene mejores beneficios que ReLU en la práctica no son tangibles
  - [Maxout](https://youtu.be/_0wdproot34?t=930)
    ```
    f(x) = max(w_1^T x + b_1, w_2^T x + b_2)
    
    Donde x es la entrada a la neurona, w_1, w_2 son vectores de pesos y b_1, b_2 son sesgos. 
    La función Maxout toma el máximo entre dos funciones lineales de la entrada, donde cada función lineal es una transformación 
    lineal de la entrada original.
    ``` 
    - Se pueden obtener mejores resultados pero su costo computacional es muy elevado


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
