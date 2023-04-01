curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -o Miniconda3-latest-MacOSX-x86_64.sh
bash Miniconda3-latest-MacOSX-x86_64.sh

- instalando miniconda
- hay que configurar la variable de entorno PYTHONPATH
If you'd prefer that conda's base environment not be activated on startup, 
   set the auto_activate_base parameter to false: 

conda config --set auto_activate_base false

pip install tensorflow
- esto es lo que instala:
Installing collected packages: 
- tensorboard-plugin-wit, pyasn1, libclang, flatbuffers, wrapt, urllib3, typing-extensions, termcolor, tensorflow-io-gcs-filesystem, tensorflow-estimator, tensorboard-data-server, six, rsa, pyasn1-modules, protobuf, packaging, oauthlib, numpy, MarkupSafe, markdown, keras, idna, grpcio, gast, charset-normalizer, certifi, cachetools, absl-py, werkzeug, scipy, requests, opt-einsum, ml-dtypes, h5py, google-pasta, google-auth, astunparse, requests-oauthlib, jax, google-auth-oauthlib, tensorboard, tensorflow
Successfully installed MarkupSafe-2.1.2 absl-py-1.4.0 astunparse-1.6.3 cachetools-5.3.0 certifi-2022.12.7 charset-normalizer-3.1.0 flatbuffers-23.3.3 gast-0.4.0 google-auth-2.17.1 google-auth-oauthlib-0.4.6 google-pasta-0.2.0 grpcio-1.53.0 h5py-3.8.0 idna-3.4 jax-0.4.8 keras-2.12.0 libclang-16.0.0 markdown-3.4.3 ml-dtypes-0.0.4 numpy-1.23.5 oauthlib-3.2.2 opt-einsum-3.3.0 packaging-23.0 protobuf-4.22.1 pyasn1-0.4.8 pyasn1-modules-0.2.8 requests-2.28.2 requests-oauthlib-1.3.1 rsa-4.9 scipy-1.10.1 six-1.16.0 tensorboard-2.12.0 tensorboard-data-server-0.7.0 tensorboard-plugin-wit-1.8.1 tensorflow-2.12.0 tensorflow-estimator-2.12.0 tensorflow-io-gcs-filesystem-0.32.0 termcolor-2.2.0 typing-extensions-4.5.0 urllib3-1.26.15 werkzeug-2.2.3 wrapt-1.14.1

### [Redes neuronales - Cómo Aprenden](https://www.youtube.com/watch?v=CU24iC3grq8)
- Neurona. Proceso de **activación** y disparo. Disparo que activa otra neurona
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
- `s => suma(x1*2, x2, x3) > 2`