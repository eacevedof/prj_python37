# https://youtu.be/cDMoaMnbQUc?t=778
import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

# entradas con numeros de pulgadas
entradas = np.array([1, 6, 30, 7, 70, 43, 503, 201, 1005, 99], dtype=float)
resultados = np.array([0.0254, 0.1524, 0.762, 0.1778, 1.778, 1.0922, 12.776, 5.1054, 25.527, 2.514], dtype=float)

# topografia de la red
# 1 capa de entrada con una neurona de entrada y una de salida

# units = capas
capa1 = tf.keras.layers.Dense(units=1, input_shape=[1])

modelo = tf.keras.Sequential(capa1)

# asignar un optimizador y una metrica de perdida
modelo.compile(
    optimizer = tf.keras.optimizers.Adam(0.1),

    # tiene como prioridad corregir los grandes errores aunque sean pocos antes que los pequeños errores
    loss = "mean_squared_error"
)

print("Entrenando")

#entrenando el modelo
# epochs son los ciclos de entrenamiento
entrenamiento = modelo.fit(entradas, resultados, epochs=500, verbose=False)

# guardamos la red despues de su entrenamiento
modelo.save("red-uno")
modelo.save_weights("pesos.red-uno")

# verificar que la red se entrenó
print("terminado")

# prediccion
i = input("ingresa el valor en pulgadas")