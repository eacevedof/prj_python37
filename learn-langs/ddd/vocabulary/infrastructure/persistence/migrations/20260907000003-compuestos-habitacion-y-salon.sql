-- Learn Languages App - Migration
-- Migration: 20260907000003-compuestos-habitacion-y-salon
-- Description: Eduardo, sobre la frase 3 de la tarjeta 101 (de wandklok): "la pila del
--   reloj... no podria ser de wandklok batterij is leeg geworden?". La respuesta va
--   entera en la ayuda de la 101: (1) de wandklok batterij con ESPACIO esta mal, los
--   compuestos se escriben pegados (de Engelse ziekte); (2) aun pegado no se dice, porque
--   el compuesto nombra el TIPO de cosa y van la pertenencia concreta, y ademas con tres
--   piezas el neerlandes rompe con van; (3) is leeg geworden es gramatical pero no es lo
--   que se dice: de batterij is leeg / is op / is leeggegaan / is leeggeraakt.
--
--   Y como la duda destapa una regla que resuelve el genero de media casa, se escribe el
--   bloque compartido "🧱 Las palabras compuestas" y se inyecta en las 22 tarjetas
--   compuestas de los grupos 5 (habitacion) y 6 (salon). La regla de oro: el articulo lo
--   manda SIEMPRE la ultima pieza, y se demuestra con las propias tarjetas del mazo
--   (de boekenkast pese a het boek, het deurkozijn pese a de deur, de bedrand pese a het
--   bed). Incluye las letras de union -en- y -s-, y los dos casos en que NO se pega:
--   adjetivo + sustantivo (de staande lamp, de open haard) y guion (de stereo-installatie).
--
--   21 de las 22 tarjetas tenian rules_help vacio, asi que se les escribe entera: una
--   primera linea propia con el desglose de SU compuesto y su articulo, mas el bloque. La
--   128 (de open haard) ya tenia ayuda, asi que solo se le concatena el bloque.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;


-- 68
UPDATE words_es SET rules_help = 'de slaapkamer = el dormitorio. Compuesto de slapen (dormir) + de kamer (habitacion), y el articulo lo manda kamer: de.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 68;

-- 71
UPDATE words_es SET rules_help = 'het nachtkastje = la mesilla de noche. Compuesto de de nacht (la noche) + het kastje (el armarito), y el articulo lo manda kastje: het. Aqui se juntan dos reglas, porque kastje es diminutivo y TODO diminutivo en -je es het.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 71;

-- 72
UPDATE words_es SET rules_help = 'het dekbed = el edredon. Compuesto de dekken (cubrir) + het bed (la cama), y el articulo lo manda bed: het.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 72;

-- 78
UPDATE words_es SET rules_help = 'het rolgordijn = la persiana enrollable. Compuesto de de rol (el rollo) + het gordijn (la cortina), y el articulo lo manda gordijn: het.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 78;

-- 84
UPDATE words_es SET rules_help = 'de oplader = el cargador. Sale del separable opladen (cargar) mas la terminacion -er, que fabrica el aparato o la persona que hace algo. Todos los nombres en -er son de: de oplader, de wekker, de speler.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 84;

-- 88
UPDATE words_es SET rules_help = 'het hoofdeinde = el cabecero de la cama. Compuesto de het hoofd (la cabeza) + het einde (el extremo), y el articulo lo manda einde: het. Su opuesto es het voeteneinde, los pies de la cama.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 88;

-- 89
UPDATE words_es SET rules_help = 'de bedbodem = el somier. Compuesto de het bed (la cama) + de bodem (el fondo), y aunque bed sea het, el articulo lo manda bodem: de.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 89;

-- 91
UPDATE words_es SET rules_help = 'de fotolijst = el marco de foto. Compuesto de de foto + de lijst (el marco), y el articulo lo manda lijst: de.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 91;

-- 92
UPDATE words_es SET rules_help = 'de gloeilamp = la bombilla. Compuesto de gloeien (arder, estar al rojo) + de lamp, y el articulo lo manda lamp: de. La de bajo consumo es de spaarlamp, de sparen (ahorrar).

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 92;

-- 95
UPDATE words_es SET rules_help = 'het deurkozijn = el marco de la puerta. Compuesto de de deur (la puerta) + het kozijn (el marco de obra), y aunque deur sea de, el articulo lo manda kozijn: het.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 95;

-- 97
UPDATE words_es SET rules_help = 'de bedrand = el borde de la cama. Compuesto de het bed + de rand (el borde), y aunque bed sea het, el articulo lo manda rand: de.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 97;

-- 98
UPDATE words_es SET rules_help = 'het stopcontact = el enchufe de la pared. Compuesto de de stop (el tapon) + het contact, y aunque stop sea de, el articulo lo manda contact: het. Ojo que de stekker es el otro enchufe, el del cable.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 98;

-- 106
UPDATE words_es SET rules_help = 'de salontafel = la mesa de centro. Compuesto de de salon + de tafel, y el articulo lo manda tafel: de.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 106;

-- 107
UPDATE words_es SET rules_help = 'de boekenkast = la estanteria de libros. Compuesto de het boek (el libro) + de kast (el armario), con una -EN- de union en medio, y el articulo lo manda kast: de.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 107;

-- 109
UPDATE words_es SET rules_help = 'de afstandsbediening = el mando a distancia. Compuesto de de afstand (la distancia) + de bediening (el manejo), con una -S- de union en medio, y el articulo lo manda bediening: de. Ademas todo nombre en -ing es de.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 109;

-- 110
UPDATE words_es SET rules_help = 'de stereo-installatie = el equipo de musica. Compuesto de stereo + de installatie, y aqui va con GUION: cuando la primera pieza acaba en vocal y la segunda empieza por vocal, el neerlandes mete un guion para que no choquen.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 110;

-- 111
UPDATE words_es SET rules_help = 'de luidspreker = el altavoz. Compuesto de luid (alto, fuerte) + de spreker (el que habla), y el articulo lo manda spreker: de. En plural, de luidsprekers.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 111;

-- 117
UPDATE words_es SET rules_help = 'de staande lamp = la lampara de pie. Y aqui NO hay compuesto: staande es un adjetivo (del participio de staan), asi que va SEPARADO de lamp. Por eso no se escribe «staandelamp».

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 117;

-- 118
UPDATE words_es SET rules_help = 'de plafondlamp = la lampara de techo. Compuesto de het plafond (el techo) + de lamp, y aunque plafond sea het, el articulo lo manda lamp: de.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 118;

-- 121
UPDATE words_es SET rules_help = 'het raamkozijn = el marco de la ventana. Compuesto de het raam (la ventana) + het kozijn (el marco), y el articulo lo manda kozijn: het.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 121;

-- 101
UPDATE words_es SET rules_help = 'de wandklok = el reloj de pared. Compuesto de de wand (la pared) + de klok (el reloj), y el articulo lo manda klok: de.

❓ La duda que trajo esta tarjeta: «la pila del reloj», ¿no podria ser de wandklok batterij is leeg geworden? Hay tres cosas ahi, y solo una es discutible.

⚠️ Primero, de wandklok batterij con ESPACIO esta mal. Los compuestos neerlandeses se escriben pegados siempre. Separarlos es el error que ellos llaman de Engelse ziekte, la enfermedad inglesa, por calcar wall clock battery. Pegado seria de wandklokbatterij.

🔑 Segundo, la regla que lo decide: Aunque se pegue, aqui no se dice. El compuesto nombra el TIPO de cosa (de autosleutel es esa clase de llave, het fietsslot es esa clase de candado), mientras que van + el sustantivo nombra la pertenencia CONCRETA (de sleutel van de auto es la llave de ese coche). La pila de tu reloj es pertenencia concreta, asi que van. Y hay un motivo extra: wand + klok + batterij serian TRES piezas, y a partir de tres el neerlandes prefiere romper con van aunque morfologicamente pueda pegarlas.

🔋 Tercero, la pila: Is leeg geworden es gramatical, pero no es lo que se dice. leeg worden es volverse vacio, un proceso abstracto que con pilas no se usa.

Lo que se dice de verdad, de mas a menos frecuente:

| forma | matiz |
|---|---|
| De batterij is **leeg**. | esta gastada. La que dirias el 90% de las veces |
| De batterij is **op**. | se ha acabado, coloquial |
| De batterij is **leeggegaan**. | se ha gastado, viendolo como proceso |
| De batterij is **leeggeraakt**. | lo mismo con raken, muy idiomatico |
| De batterij moet **vervangen** worden. | hay que cambiarla |

⚠️ leeggaan y leegraken son separables, asi que en participio van juntos: leeggegaan, leeggeraakt. Nunca «leeg gegaan» en dos palabras.

🕐 Y el vocabulario del reloj, ya que estamos: voorlopen (ir adelantado), achterlopen (ir atrasado), gelijklopen (ir en hora), de wijzer (la manecilla), de batterij vervangen (cambiar la pila). De klok loopt vijf minuten voor.

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 101;

-- 128 (de open haard): ya tenia ayuda, solo se concatena el bloque
UPDATE words_es SET rules_help = rules_help || '

🧱 Las palabras compuestas, que resuelven medio genero de la casa:

En neerlandes dos sustantivos se pegan para formar uno solo, y ahi hay una regla de oro que ahorra muchisimo: el articulo lo manda SIEMPRE la ultima pieza.

| compuesto | piezas | articulo |
|---|---|---|
| de wandklok | de wand + **de klok** | **de** |
| de boekenkast | het boek + **de kast** | **de** |
| het deurkozijn | de deur + **het kozijn** | **het** |
| de bedrand | het bed + **de rand** | **de** |
| de plafondlamp | het plafond + **de lamp** | **de** |
| het dekbed | dekken + **het bed** | **het** |

Fijate en boekenkast, bedrand y plafondlamp: la primera pieza es het y aun asi el compuesto es de, porque manda la ultima. Y en deurkozijn al reves.

⚠️ Se escriben PEGADAS, nunca con espacio. Escribir «wand klok» o «boeken kast» es el error que los neerlandeses llaman de Engelse ziekte, la enfermedad inglesa, de calcar el ingles. Si dudas, pegalo.

🔗 A veces aparece una letra de union en medio, y hay que aprenderla con la palabra:
• -EN- : de boekenkast, de pannenkoek (la tortita), het bessensap (el zumo de bayas).
• -S- : de afstandsbediening, het stationsplein (la plaza de la estacion), het verjaardagsfeest (la fiesta de cumpleaños).
• nada : de wandklok, de tafellamp, het dekbed.

🚧 Cuando NO se pega:
• Adjetivo + sustantivo van SEPARADOS: de staande lamp (la lampara de pie), de open haard (la chimenea), de zwarte kat.
• Con GUION cuando chocan dos vocales o hay una sigla o un nombre propio: de stereo-installatie, het auto-ongeluk, de tv-kast.

🔑 Compuesto o van, el criterio: el compuesto nombra el TIPO de cosa y van nombra la pertenencia concreta. de autosleutel es esa clase de llave; de sleutel van de auto es la llave de ESE coche. Y si te salen tres piezas, rompe con van: de batterij van de wandklok, no «de wandklokbatterij».'
WHERE id = 128
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧱 Las palabras compuestas%';
