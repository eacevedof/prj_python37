import tensorflow as tf
import numpy as np

celsius = np.array([-40, -10, 0, 8, 15, 22, 38], dtype=float)
fahrenheit = np.array([-40, 14, 32, 46, 59, 72, 100], dtype=float)

#capa = tf.keras.layers.Dense(units=1, input_shape=[1])
#modelo = tf.keras.Sequential([capa])

oculta1 = tf.keras.layers.Dense(units=3, input_shape=[1])
oculta2 = tf.keras.layers.Dense(units=3)
salida = tf.keras.layers.Dense(units=1)
modelo = tf.keras.Sequential([oculta1, oculta2, salida])

tasa_de_aprendizaje = 0.1

modelo.compile(
    # concretamente, Adam le permite a la red ajuste los pesos y sesgos de manera eficiente
    # de modo que aprenda y no desaprenda
    optimizer=tf.keras.optimizers.Adam(tasa_de_aprendizaje),
    # error de media cuadratica. Una pequeña cantidad de grandes errores es peor que una cantidad grande de pequeños errores
    loss="mean_squared_error"
)

ciclos_de_aprendizaje = 1000
# entrenamiento
historial = modelo.fit(celsius, fahrenheit, epochs=ciclos_de_aprendizaje, verbose=False)

print("modelo entrenado")

#reultado de la funcion de perdida
import matplotlib.pyplot as plt

plt.xlabel("# ciclos (epochs)")
plt.ylabel("magnitud de perdida")
plt.plot(historial.history["loss"])
plt.show()

# comprobar si predice
result = modelo.predict([100])
print("100 C en fahrenheit deberia ser 212")
print(result)

print("peso, sesgo")
print(oculta1.get_weights())
print(oculta2.get_weights())
print(salida.get_weights())