# https://youtu.be/cDMoaMnbQUc?t=778
import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

# entradas con numeros de pulgadas
entradas = np.array([1, 6, 30, 7, 70, 43, 503, 201, 1005, 99], dtype=float)
resultados = np.array([0.0254, 0.1524, 0.762, 0.1778, 1.778, 1.0922, 12.776, 5.1054, 25.527, 2.514], dtype=float)

# topografia de la red
# 1 capa de entrada con una neurona de entrada y una de salida
capa1 = tf.keras.layers.Dense()