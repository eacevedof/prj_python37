[index](../readme.md)

[Tu primer clasificador de imágenes con Python y Tensorflow](https://www.youtube.com/watch?v=j6eGHROLKP8&list=PLZ8REt5zt2Pn0vfJjTAPaDVSACDvnuGiG&index=2)
- Una imagen de 100px x 100px (10.000 pixeles) daría una entrada de 10.000 neuronas en la capa de entrada
- Esta misma imagen la podemos reducir al mínimo posible. 28px x 28px = 784 neuronas de entrada y 10 neuronas de salida
- 10 porque son las categorias: camiseta, pantalon, falda, etc.
- [emulador de regresion y clasificacion](https://playground.tensorflow.org/#activation=tanh&batchSize=10&dataset=circle&regDataset=reg-plane&learningRate=0.03&regularizationRate=0&noise=0&networkShape=2,2&seed=0.95468&showTestData=false&discretize=false&percTrainData=40&x=true&y=true&xTimesY=false&xSquared=false&ySquared=false&cosX=false&sinX=false&cosY=false&sinY=false&collectStats=false&problem=regression&initZero=false&hideText=false)
- Si se trata de un problema de regresion es decir que sea lineal entonces se podria hacer con dos capas. Las capas de entrada y salida.
- Este planteamiento no serviria para una clasifcación puesto que los limites del dominio no es trivial.
- Aqui entran en juego las [Capas ocultas y las funciones de activación](https://youtu.be/j6eGHROLKP8?list=PLZ8REt5zt2Pn0vfJjTAPaDVSACDvnuGiG&t=301)