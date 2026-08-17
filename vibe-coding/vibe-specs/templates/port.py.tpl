from typing import Protocol


# Un PUERTO no lleva @final (algo tiene que poder cumplirlo) ni el sufijo "_port"
# (la carpeta ya dice lo que es).
class {{Capacidad}}(Protocol):
    """Puerto: <que necesita este modulo del otro, en una linea>.

    Lo declara QUIEN LO NECESITA. Lo cumple, sin saberlo, un adaptador del otro
    modulo (`{{otro_modulo}}_mod/infrastructure/adapters/`).

    DOS REGLAS:
      1. Entra y sale en PRIMITIVOS (int, bool, str). Es una frontera.
      2. NUNCA lanza. Si lanzara la excepcion de su modulo, cruzaria hasta un
         controller que no la captura y acabaria siendo un error 500.
    """

    def <metodo>(self, <argumento>: int) -> bool:
        ...
