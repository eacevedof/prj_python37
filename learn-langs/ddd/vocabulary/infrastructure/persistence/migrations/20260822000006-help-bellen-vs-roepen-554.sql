-- 554 «Bel haar maar even» — bellen es SIEMPRE el teléfono; llamar a voces es roepen.
-- El texto español era ambiguo («llámala un momento, anda» vale para las dos), así que
-- se desambigua sin paréntesis, que se locutan. Idempotente por el guard del bloque 📞.

UPDATE words_es
SET text = 'llámala un momento por teléfono, anda',
    updated_at = datetime('now')
WHERE id = 554
  AND text = 'llámala un momento, anda';

UPDATE words_es
SET rules_help = REPLACE(
        rules_help,
        '📐 Imperativo:',
        '📞 Llamar son siete verbos en neerlandés: el español los mete todos en uno. Lo que hay que grabar a fuego: bellen es SIEMPRE el teléfono, y llamar a voces es roepen.

| en español | neerlandés | ejemplo |
|---|---|---|
| llamar por teléfono | **bellen** / **opbellen** | Bel haar maar even. — Llámala un momento. |
| llamar a voces, dar una voz | **roepen** | Roep haar maar even. — Llámala, dale una voz. |
| llamar al timbre | **aanbellen** | Er wordt aangebeld. — Llaman a la puerta. |
| llamar a la puerta con los nudillos | **kloppen** | Er wordt geklopt. — Están llamando. |
| llamar por turno o por megafonía | **oproepen** | Neemt u plaats, ik roep u zo op. |
| llamar = ponerle nombre a alguien | **noemen** | Ze noemen hem Bertje. — Le llaman Bertje. |
| llamarse | **heten** | Hoe heet ze? — ¿Cómo se llama? |

🔔 El truco para no fallar nunca: de bel es el timbre y la campana, así que bellen es cosa de aparatos que suenan — el timbre, el teléfono. Con la voz jamás. Para la voz está roepen, que es el mismo verbo que el rufen alemán.

Tu escena del patio: Alicia está jugando a diez metros y la profesora dice «llámala un momento, anda» → Roep haar maar even. Con Bel haar maar even le estarías pidiendo que le marque el número.

⚠️ Esta tarjeta es la del teléfono. La misma frase con la voz es Roep haar maar even, palabra por palabra igual salvo el verbo.

Roepen es irregular (fuerte):
• presente — ik roep · jij roept · hij roept · wij roepen
• pasado — riep (singular) · riepen (plural)
• participio — geroepen: Ik heb je geroepen = te he llamado.

🗣 roepen en el día a día:
• Ik roep je wel als het eten klaar is. — Ya te llamo cuando esté la comida.
• Roep even als je klaar bent. — Da una voz cuando termines.
• Het kind roept om zijn moeder. — El niño llama a su madre a gritos.
• Niet schreeuwen! — schreeuwen es gritar por volumen, no llamar a nadie.

🔄 Los compuestos, que se parecen y no son lo mismo:
• terugbellen = devolver la llamada, teléfono — Ik bel je zo terug.
• terugroepen = hacer volver a alguien, retirar — Ze riepen hem terug.
• omroepen = anunciar por megafonía — Ze roepen je naam om.
• uitroepen = exclamar, y también proclamar.

📐 Imperativo:'
    ),
    updated_at = datetime('now')
WHERE id = 554
  AND rules_help LIKE '%📐 Imperativo:%'
  AND rules_help NOT LIKE '%📞 Llamar son siete%';
