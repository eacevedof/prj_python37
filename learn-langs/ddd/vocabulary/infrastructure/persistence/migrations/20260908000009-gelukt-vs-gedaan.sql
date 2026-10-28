-- Learn Languages App - Migration
-- Migration: 20260908000009-gelukt-vs-gedaan
-- Description: Eduardo: "1049 de betaling is gelukt vs de betaling is gedaan".
--
--   is gedaan no esta mal, pero dice otra cosa. lukken habla de EXITO: implica que la cosa
--   podia haber fallado y no fallo. doen habla de EJECUCION: dice que la accion se llevo a
--   cabo, sin pronunciarse sobre si funciono. La frase que lo separa de golpe es
--   Ik heb de betaling gedaan, maar hij is mislukt (he hecho el pago, pero ha fallado): las
--   dos cosas son compatibles, luego no significan lo mismo.
--
--   Y de paso entra su antonimo, mislukken, que es lo que pone la pantalla del datafono
--   cuando el pago no cuela y que NO estaba en el mazo. Tampoco estaban verwerkt,
--   voltooid ni afrekenen, que son las otras maneras de decir que un pago esta hecho.
--
--   Se añade ademas a la 1049 el bloque "🎯 lukken o goedkomen" de la migracion
--   20260907000010, que no le habia llegado porque aquella solo fue a las tarjetas 301,
--   303, 310, 318 y 333. La 1049 usa gelukt, asi que le corresponde.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. La 1049: gelukt o gedaan
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: De betaling is gelukt frente a De betaling is gedaan.

🔑 La diferencia: is gedaan no esta mal, pero dice otra cosa. lukken habla de EXITO y doen habla de EJECUCION. gelukt significa que salio bien, dando por hecho que podia haber fallado; gedaan significa que la accion se hizo, sin decir si funciono.

⚠️ La frase que lo separa de golpe, y que ademas se oye: Ik heb de betaling gedaan, maar hij is mislukt. (He hecho el pago, pero ha fallado.) Las dos cosas son compatibles a la vez, asi que no significan lo mismo.

| frase | que dice | donde la ves |
|---|---|---|
| De betaling **is gelukt**. | Ha salido bien. | la pantalla del datafono, la app del banco |
| De betaling **is mislukt**. | Ha fallado. | la misma pantalla, cuando no cuela |
| De betaling **is verwerkt**. | Ha sido procesada. | el banco |
| De betaling **is voltooid**. | Se ha completado. | apps y textos formales |
| Ik **heb betaald**. | He pagado. | lo natural al hablar |
| De rekening **is voldaan**. | La factura está saldada. | cartas y facturas |

📋 Y ojo, que een betaling doen SI es colocacion valida: Ik heb een betaling gedaan es correcto y se usa. Lo que pasa es que en pasiva, De betaling is gedaan suena mas pobre que is verwerkt o is voltooid, y no dice lo que dice gelukt.

🚫 El antonimo es mislukken: El prefijo mis- se pega a un verbo y lo convierte en su version fallida o torcida.

Los que mas vas a ver:
• lukken → mislukken — salir bien → fallar. De betaling is mislukt.
• gaan → misgaan — ir → ir mal. Er ging iets mis. (algo salió mal)
• verstaan → het misverstand — entender → el malentendido.
• gebruiken → het misbruik — usar → el abuso.
• zich gedragen → zich misdragen — portarse → portarse mal.

📐 Y el recordatorio gramatical de lukken: su auxiliar es ZIJN (is gelukt, nunca «heeft gelukt») y el sujeto es la COSA, no la persona. Por eso aqui el sujeto es de betaling. Si quieres meterte tu, vas en dativo: Het is me gelukt (lo he conseguido).

💳 El vocabulario del pago en Paises Bajos, que necesitaras de verdad: pinnen (pagar con tarjeta de debito, y es lo normal en todas partes), de pinpas (la tarjeta), contant (efectivo, cada vez menos aceptado), afrekenen (pagar la cuenta en un bar), de rekening (la cuenta o la factura), het bedrag (el importe), de bon (el recibo), de overschrijving (la transferencia) y Tikkie (la app con la que todo el mundo se reclama dinero entre amigos).

🏋️ Ejercicio: «el pago ha fallado» → De betaling is ___. (Respuesta: mislukt.)'
WHERE id = 1049
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';

-- =============================================================================
-- 2. A la 1049 le corresponde tambien el bloque de lukken, que no le habia llegado
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🎯 lukken o goedkomen, que no son lo mismo:

Los dos se traducen por salir bien, pero miran a cosas distintas: lukken es que una accion CONCRETA tenga exito, y goedkomen es que una SITUACION acabe arreglandose.

| verbo | que dice | ejemplo |
|---|---|---|
| **lukken** | una accion concreta sale, se consigue | Het **lukt** me niet. (no me sale) |
| **goedkomen** | una situacion se arregla con el tiempo | Het **komt** wel **goed**. (ya veras) |
| **slagen** | aprobar, tener exito formal | Ik ben **geslaagd** voor mijn examen. |
| **het redden** | apañarselas, llegar a tiempo | Ik **red** het niet. (no llego) |
| **werken** | funcionar, de aparatos | Het **werkt** niet. |

⚠️ El gotcha gordo de lukken. La persona NUNCA es el sujeto: la cosa es la que lukt, y tu vas en DATIVO. Se dice Het lukt me, y nunca «Ik luk het», que es la tentacion directa del yo lo consigo español.

📐 Y su auxiliar es ZIJN: Het is gelukt, De betaling is gelukt. Nunca «heeft gelukt».

🔑 El truco para elegir entre los dos: Pregunta si hay un INTENTO detras. Si alguien esta intentando algo ahora, lukken. Si solo hay preocupacion y tiempo por delante, goedkomen.'
WHERE id = 1049
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🎯 lukken o goedkomen%';
