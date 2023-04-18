import tensorflow as tf
import numpy as np

celsius = np.array([-40, -10, 0, 8, 15, 22, 38], dtype=float)
fahrenheit = np.array([-40, 14, 32, 46, 59, 72, 100], dtype=float)

capa = tf.keras.layers.Dense(units=1, input_shape=[1])
modelo = tf.keras.Sequential([capa])

modelo.compile(
    # concretamente, Adam le permite a la red ajuste los pesos y sesgos de manera eficiente
    # de modo que aprenda y no desaprenda
    optimizer=tf.keras.optimizers.Adam()
)