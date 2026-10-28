-- 563 «Ik geef het je zo» — «Ik geef het nu aan jou» TAMBIÉN es correcto:
-- cambia dos cosas a la vez (je → aan jou = contraste · zo → nu = otro momento).
-- Idempotente: solo inserta si el bloque 🤲 todavía no está en la ayuda.

UPDATE words_es
SET rules_help = REPLACE(
        rules_help,
        '📐 Oración principal:',
        '🤲 Ik geef het nu aan jou sí se puede: es neerlandés correcto y bien formado. Lo que pasa es que has cambiado DOS cosas a la vez, y cada una mueve el significado por su lado.

| lo que cambiaste | de | a | qué pasa |
|---|---|---|---|
| el destinatario | je | aan jou | de neutro a CONTRASTIVO: a TI, no a otro |
| el momento | zo | nu | de «enseguida» a «en este mismo instante» |

Juntas, Ik geef het nu aan jou dice «te lo doy a TI ahora mismo», que no es lo que dice la tarjeta.

🕐 Lo que de verdad falla es el zo: en español «ahora te lo doy» casi nunca significa «en este instante», significa «enseguida». Y ese enseguida es zo, no nu.

Los ahora del neerlandés:

| neerlandés | cuándo es | ejemplo |
|---|---|---|
| **nu** | en este mismo instante | Ik doe het nu. — Lo hago ahora. |
| **zo** | enseguida, dentro de un momento | Ik geef het je zo. — Ahora te lo doy. |
| **zo meteen** | ahora mismito, ya casi | Ik ben er zo meteen. |
| **meteen / direct** | inmediatamente, sin demora | Ik kom meteen. |
| **straks** | luego, más tarde | Ik bel je straks. — Te llamo luego. |
| **net** | hace nada, ya pasó | Ik heb het net gedaan. |

⚠️ zo tiene tres vidas: «así» (Doe het zo), «tan» (zo groot = tan grande) y «enseguida» (Ik kom zo). Lo decide el contexto, y aquí es el tercero.

🎯 je o aan jou, cuándo cada uno:
• sin preposición y delante = neutro, átono, información ya sabida — Ik geef het je zo.
• con aan y al final = tónico: contraste, énfasis o destinatario nuevo — Ik geef het aan jou, niet aan hem.

Regla de peso: lo ligero y sabido va delante, lo pesado y nuevo al final. Por eso un destinatario largo pide aan — Ik geef het boek aan de nieuwe collega van Piet.

Las cuatro maneras de decirlo, todas correctas:

| construcción | ejemplo | cuándo |
|---|---|---|
| dos pronombres | Ik geef **het je** zo. | lo normal: el directo het va primero |
| indirecto pronombre + directo sustantivo | Ik geef **je het boek**. | con sustantivo se invierte: primero je |
| con aan al final | Ik geef het **aan jou**. | contraste o énfasis en el destinatario |
| sustantivo + aan | Ik geef het boek **aan mijn broer**. | destinatario largo o nuevo |

⚠️ Lo único que sí está mal es Ik geef je het: het es el pronombre más ligero de todos y no puede quedarse detrás de otro pronombre. En cuanto le pones aan deja de competir y se arregla — Ik geef het aan jou.

📐 Oración principal:'
    ),
    updated_at = datetime('now')
WHERE id = 563
  AND rules_help LIKE '%📐 Oración principal:%'
  AND rules_help NOT LIKE '%🤲 Ik geef het nu aan jou%';
