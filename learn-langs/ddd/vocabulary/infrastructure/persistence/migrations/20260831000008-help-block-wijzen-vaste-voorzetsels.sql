-- Learn Languages App - Bloque compartido: las preposiciones fijas de la familia de wijzen
-- Migration: 20260831000008-help-block-wijzen-vaste-voorzetsels.sql
-- Description: Eduardo, sobre la 834: «es importante agregar las preposiciones fijas; toewijzen
--   esta bien pero con sus preposiciones, en este caso aan o las que haya». La 834 escribia
--   «…toe aan de variabele» pero no marcaba el AAN como REGIMEN, que es lo que convierte el verbo
--   en usable. Norma nueva y permanente (guardada en memoria junto a las del articulo y el
--   antonimo): todo verbo se cita con su preposicion fija, y si no rige ninguna se dice
--   explicitamente que es transitivo pelado.
--   Bloque 🧲 IDENTICO byte a byte con la tabla de regimen de la familia (toewijzen aan · wijzen
--   op = advertir de · wijzen naar = apuntar hacia · verwijzen naar · aanwijzen als · uitwijzen
--   naar en su sentido legal · wijzigen in/naar), las que NO rigen nada (afwijzen, aanwijzen y
--   uitwijzen-demostrar, transitivos pelados), las DOS construcciones de toewijzen (con aan al
--   final para el destinatario pesado, sin aan con el pronombre delante — la regla de peso, la
--   misma de la 563), la forma ER + preposicion cuando el objeto no es un sustantivo (Ik wijs je
--   EROP dat…, que es lo que hace que la preposicion parezca desaparecer al oido), los
--   sustantivos con su articulo Y su preposicion (de toewijzing aan · de afwijzing VAN, que no
--   es la del verbo · de verwijzing naar · de aanwijzing voor · de wijziging · de wijsvinger) y
--   el par de antonimos toewijzen ↔ afwijzen.
--   Va a las 21 tarjetas de la familia (833-859 + 856). Doce de ellas tenian rules_help a NULL
--   (835, 843, 844, 846, 847, 849, 850, 852, 853, 855, 858, 859) y se crean enteras, cada una
--   explicando el regimen que ensena su propia frase; incluye la trampa de wijzigen, que se
--   parece a la familia pero es verbo debil y aparte.
--   100% aditiva e idempotente (guard por marca y por rules_help IS NULL).

-- ==============================================================================
-- 1. Las 9 tarjetas que ya tienen ayuda: el bloque se anade al final
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧲 Las preposiciones fijas de la familia de wijzen
En neerlandes la preposicion es PARTE del verbo: no se aprende «wijzen» sino «wijzen op». Cambiarla cambia el significado, y ninguna se deduce del espanol, asi que hay que aprenderlas pegadas al verbo, como una sola pieza.

| verbo | rige | que significa con esa preposicion | ejemplo |
|---|---|---|---|
| **toewijzen aan** | aan | asignar o adjudicar algo A alguien | Een budget toewijzen **aan** het project. |
| **wijzen op** | op | advertir de algo, llamar la atencion sobre | Ik wijs je **op** het risico. |
| **wijzen naar** | naar | apuntar hacia, con el dedo | Hij wees **naar** de deur. |
| **verwijzen naar** | naar | remitir a, hacer referencia a | De dokter verwijst me **naar** een specialist. |
| **aanwijzen als** | als | designar como, nombrar | Hij is aangewezen **als** teamleider. |
| **uitwijzen naar** | naar | deportar a un pais, en sentido legal | Ze werden uitgewezen **naar** hun land. |
| **wijzigen in / naar** | in, naar | cambiar una cosa POR otra | De afspraak wijzigen **naar** volgende week. |

⚠️ Y las que NO rigen ninguna, que tambien hay que saberlo: afwijzen, aanwijzen y uitwijzen (en su sentido de demostrar) son transitivos pelados, con objeto directo y sin preposicion detras. De bank wijst de aanvraag af. · De tijd zal het uitwijzen.

🔄 toewijzen tiene DOS construcciones, igual que geven:
• con aan = cuando el destinatario es largo, nuevo o va destacado, y entonces se va al final. De gemeente heeft een budget toegewezen aan het project.
• sin aan = cuando el destinatario es un pronombre, que va delante y pegado. De steward wijst je een stoel toe.
Lo decide la regla de peso: lo ligero y ya sabido delante, lo pesado y nuevo al final.

🧩 Cuando el objeto de la preposicion NO es un sustantivo, la preposicion se pega a ER y se coloca sola en la frase: Ik wijs je EROP dat het risico groot is. — Te advierto de que el riesgo es grande. Igual con daarop y waarop. Esto es lo que hace que la preposicion parezca desaparecer al oido.

🔤 Los sustantivos de la familia, con su articulo y su preposicion: de toewijzing aan (la asignacion) · de afwijzing van (la denegacion de) · de verwijzing naar (la remision a) · de aanwijzing voor (el indicio de) · de wijziging (la modificacion, sin preposicion) · de wijsvinger (el indice, el dedo que senala).

↔️ Los antonimos del par principal: toewijzen (asignar, conceder) ↔ afwijzen (denegar), y sus sustantivos de toewijzing ↔ de afwijzing.',
    updated_at = datetime('now')
WHERE id IN (833, 834, 842, 845, 848, 851, 854, 856, 857)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧲 Las preposiciones fijas%';

-- ==============================================================================
-- 2. Tarjeta 835: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'toewijzen aparece aqui SIN aan porque el destinatario no se menciona: solo se dice que se asigno un tipo, no a que. En cuanto aparece el destinatario, entra la preposicion fija: De compiler heeft automatisch een type toegewezen aan de variabele. El participio es toegewezen, con el ge- en medio porque toe- es separable. Los sustantivos: de compiler, het type, de toewijzing aan.

🧲 Las preposiciones fijas de la familia de wijzen
En neerlandes la preposicion es PARTE del verbo: no se aprende «wijzen» sino «wijzen op». Cambiarla cambia el significado, y ninguna se deduce del espanol, asi que hay que aprenderlas pegadas al verbo, como una sola pieza.

| verbo | rige | que significa con esa preposicion | ejemplo |
|---|---|---|---|
| **toewijzen aan** | aan | asignar o adjudicar algo A alguien | Een budget toewijzen **aan** het project. |
| **wijzen op** | op | advertir de algo, llamar la atencion sobre | Ik wijs je **op** het risico. |
| **wijzen naar** | naar | apuntar hacia, con el dedo | Hij wees **naar** de deur. |
| **verwijzen naar** | naar | remitir a, hacer referencia a | De dokter verwijst me **naar** een specialist. |
| **aanwijzen als** | als | designar como, nombrar | Hij is aangewezen **als** teamleider. |
| **uitwijzen naar** | naar | deportar a un pais, en sentido legal | Ze werden uitgewezen **naar** hun land. |
| **wijzigen in / naar** | in, naar | cambiar una cosa POR otra | De afspraak wijzigen **naar** volgende week. |

⚠️ Y las que NO rigen ninguna, que tambien hay que saberlo: afwijzen, aanwijzen y uitwijzen (en su sentido de demostrar) son transitivos pelados, con objeto directo y sin preposicion detras. De bank wijst de aanvraag af. · De tijd zal het uitwijzen.

🔄 toewijzen tiene DOS construcciones, igual que geven:
• con aan = cuando el destinatario es largo, nuevo o va destacado, y entonces se va al final. De gemeente heeft een budget toegewezen aan het project.
• sin aan = cuando el destinatario es un pronombre, que va delante y pegado. De steward wijst je een stoel toe.
Lo decide la regla de peso: lo ligero y ya sabido delante, lo pesado y nuevo al final.

🧩 Cuando el objeto de la preposicion NO es un sustantivo, la preposicion se pega a ER y se coloca sola en la frase: Ik wijs je EROP dat het risico groot is. — Te advierto de que el riesgo es grande. Igual con daarop y waarop. Esto es lo que hace que la preposicion parezca desaparecer al oido.

🔤 Los sustantivos de la familia, con su articulo y su preposicion: de toewijzing aan (la asignacion) · de afwijzing van (la denegacion de) · de verwijzing naar (la remision a) · de aanwijzing voor (el indicio de) · de wijziging (la modificacion, sin preposicion) · de wijsvinger (el indice, el dedo que senala).

↔️ Los antonimos del par principal: toewijzen (asignar, conceder) ↔ afwijzen (denegar), y sus sustantivos de toewijzing ↔ de afwijzing.',
    updated_at = datetime('now')
WHERE id = 835
  AND rules_help IS NULL;

-- ==============================================================================
-- 3. Tarjeta 843: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'wijzigen es transitivo: el objeto va pelado, sin preposicion (de afspraak wijzigen). El naar de esta frase no es el regimen del verbo sino el DESTINO del cambio, y ahi compiten wijzigen naar y wijzigen in, casi intercambiables. Ojo con la trampa de la familia: wijzigen se parece a wijzen pero NO es pariente suyo — es debil y regular (wijzigt, wijzigde, gewijzigd). Los sustantivos: de afspraak (la cita), de wijziging (la modificacion). Antonimo practico: laten zoals het is, o handhaven (mantener).

🧲 Las preposiciones fijas de la familia de wijzen
En neerlandes la preposicion es PARTE del verbo: no se aprende «wijzen» sino «wijzen op». Cambiarla cambia el significado, y ninguna se deduce del espanol, asi que hay que aprenderlas pegadas al verbo, como una sola pieza.

| verbo | rige | que significa con esa preposicion | ejemplo |
|---|---|---|---|
| **toewijzen aan** | aan | asignar o adjudicar algo A alguien | Een budget toewijzen **aan** het project. |
| **wijzen op** | op | advertir de algo, llamar la atencion sobre | Ik wijs je **op** het risico. |
| **wijzen naar** | naar | apuntar hacia, con el dedo | Hij wees **naar** de deur. |
| **verwijzen naar** | naar | remitir a, hacer referencia a | De dokter verwijst me **naar** een specialist. |
| **aanwijzen als** | als | designar como, nombrar | Hij is aangewezen **als** teamleider. |
| **uitwijzen naar** | naar | deportar a un pais, en sentido legal | Ze werden uitgewezen **naar** hun land. |
| **wijzigen in / naar** | in, naar | cambiar una cosa POR otra | De afspraak wijzigen **naar** volgende week. |

⚠️ Y las que NO rigen ninguna, que tambien hay que saberlo: afwijzen, aanwijzen y uitwijzen (en su sentido de demostrar) son transitivos pelados, con objeto directo y sin preposicion detras. De bank wijst de aanvraag af. · De tijd zal het uitwijzen.

🔄 toewijzen tiene DOS construcciones, igual que geven:
• con aan = cuando el destinatario es largo, nuevo o va destacado, y entonces se va al final. De gemeente heeft een budget toegewezen aan het project.
• sin aan = cuando el destinatario es un pronombre, que va delante y pegado. De steward wijst je een stoel toe.
Lo decide la regla de peso: lo ligero y ya sabido delante, lo pesado y nuevo al final.

🧩 Cuando el objeto de la preposicion NO es un sustantivo, la preposicion se pega a ER y se coloca sola en la frase: Ik wijs je EROP dat het risico groot is. — Te advierto de que el riesgo es grande. Igual con daarop y waarop. Esto es lo que hace que la preposicion parezca desaparecer al oido.

🔤 Los sustantivos de la familia, con su articulo y su preposicion: de toewijzing aan (la asignacion) · de afwijzing van (la denegacion de) · de verwijzing naar (la remision a) · de aanwijzing voor (el indicio de) · de wijziging (la modificacion, sin preposicion) · de wijsvinger (el indice, el dedo que senala).

↔️ Los antonimos del par principal: toewijzen (asignar, conceder) ↔ afwijzen (denegar), y sus sustantivos de toewijzing ↔ de afwijzing.',
    updated_at = datetime('now')
WHERE id = 843
  AND rules_help IS NULL;

-- ==============================================================================
-- 4. Tarjeta 844: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'Transitivo puro: gewijzigd no lleva preposicion detras, el objeto va directo (de regels wijzigen). Y fijate en el participio, gewijzigd CON ge-, porque wijzigen no tiene prefijo atono delante — al reves que afgewezen o verwezen. Los sustantivos: de gemeente (el ayuntamiento), de regel y su plural de regels (la norma), de wijziging.

🧲 Las preposiciones fijas de la familia de wijzen
En neerlandes la preposicion es PARTE del verbo: no se aprende «wijzen» sino «wijzen op». Cambiarla cambia el significado, y ninguna se deduce del espanol, asi que hay que aprenderlas pegadas al verbo, como una sola pieza.

| verbo | rige | que significa con esa preposicion | ejemplo |
|---|---|---|---|
| **toewijzen aan** | aan | asignar o adjudicar algo A alguien | Een budget toewijzen **aan** het project. |
| **wijzen op** | op | advertir de algo, llamar la atencion sobre | Ik wijs je **op** het risico. |
| **wijzen naar** | naar | apuntar hacia, con el dedo | Hij wees **naar** de deur. |
| **verwijzen naar** | naar | remitir a, hacer referencia a | De dokter verwijst me **naar** een specialist. |
| **aanwijzen als** | als | designar como, nombrar | Hij is aangewezen **als** teamleider. |
| **uitwijzen naar** | naar | deportar a un pais, en sentido legal | Ze werden uitgewezen **naar** hun land. |
| **wijzigen in / naar** | in, naar | cambiar una cosa POR otra | De afspraak wijzigen **naar** volgende week. |

⚠️ Y las que NO rigen ninguna, que tambien hay que saberlo: afwijzen, aanwijzen y uitwijzen (en su sentido de demostrar) son transitivos pelados, con objeto directo y sin preposicion detras. De bank wijst de aanvraag af. · De tijd zal het uitwijzen.

🔄 toewijzen tiene DOS construcciones, igual que geven:
• con aan = cuando el destinatario es largo, nuevo o va destacado, y entonces se va al final. De gemeente heeft een budget toegewezen aan het project.
• sin aan = cuando el destinatario es un pronombre, que va delante y pegado. De steward wijst je een stoel toe.
Lo decide la regla de peso: lo ligero y ya sabido delante, lo pesado y nuevo al final.

🧩 Cuando el objeto de la preposicion NO es un sustantivo, la preposicion se pega a ER y se coloca sola en la frase: Ik wijs je EROP dat het risico groot is. — Te advierto de que el riesgo es grande. Igual con daarop y waarop. Esto es lo que hace que la preposicion parezca desaparecer al oido.

🔤 Los sustantivos de la familia, con su articulo y su preposicion: de toewijzing aan (la asignacion) · de afwijzing van (la denegacion de) · de verwijzing naar (la remision a) · de aanwijzing voor (el indicio de) · de wijziging (la modificacion, sin preposicion) · de wijsvinger (el indice, el dedo que senala).

↔️ Los antonimos del par principal: toewijzen (asignar, conceder) ↔ afwijzen (denegar), y sus sustantivos de toewijzing ↔ de afwijzing.',
    updated_at = datetime('now')
WHERE id = 844
  AND rules_help IS NULL;

-- ==============================================================================
-- 5. Tarjeta 846: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'aanwijzen ALS es el regimen que hay que retener: designar COMO algo. Sin als, aanwijzen es simplemente senalar o designar, transitivo y pelado. La frase esta en pasiva de perfecto, que va con zijn: hij IS aangewezen, no «heeft aangewezen». Los sustantivos: de teamleider (el jefe de equipo), de aanwijzing voor (el indicio de). Antonimo: ontslaan (destituir), con het ontslag.

🧲 Las preposiciones fijas de la familia de wijzen
En neerlandes la preposicion es PARTE del verbo: no se aprende «wijzen» sino «wijzen op». Cambiarla cambia el significado, y ninguna se deduce del espanol, asi que hay que aprenderlas pegadas al verbo, como una sola pieza.

| verbo | rige | que significa con esa preposicion | ejemplo |
|---|---|---|---|
| **toewijzen aan** | aan | asignar o adjudicar algo A alguien | Een budget toewijzen **aan** het project. |
| **wijzen op** | op | advertir de algo, llamar la atencion sobre | Ik wijs je **op** het risico. |
| **wijzen naar** | naar | apuntar hacia, con el dedo | Hij wees **naar** de deur. |
| **verwijzen naar** | naar | remitir a, hacer referencia a | De dokter verwijst me **naar** een specialist. |
| **aanwijzen als** | als | designar como, nombrar | Hij is aangewezen **als** teamleider. |
| **uitwijzen naar** | naar | deportar a un pais, en sentido legal | Ze werden uitgewezen **naar** hun land. |
| **wijzigen in / naar** | in, naar | cambiar una cosa POR otra | De afspraak wijzigen **naar** volgende week. |

⚠️ Y las que NO rigen ninguna, que tambien hay que saberlo: afwijzen, aanwijzen y uitwijzen (en su sentido de demostrar) son transitivos pelados, con objeto directo y sin preposicion detras. De bank wijst de aanvraag af. · De tijd zal het uitwijzen.

🔄 toewijzen tiene DOS construcciones, igual que geven:
• con aan = cuando el destinatario es largo, nuevo o va destacado, y entonces se va al final. De gemeente heeft een budget toegewezen aan het project.
• sin aan = cuando el destinatario es un pronombre, que va delante y pegado. De steward wijst je een stoel toe.
Lo decide la regla de peso: lo ligero y ya sabido delante, lo pesado y nuevo al final.

🧩 Cuando el objeto de la preposicion NO es un sustantivo, la preposicion se pega a ER y se coloca sola en la frase: Ik wijs je EROP dat het risico groot is. — Te advierto de que el riesgo es grande. Igual con daarop y waarop. Esto es lo que hace que la preposicion parezca desaparecer al oido.

🔤 Los sustantivos de la familia, con su articulo y su preposicion: de toewijzing aan (la asignacion) · de afwijzing van (la denegacion de) · de verwijzing naar (la remision a) · de aanwijzing voor (el indicio de) · de wijziging (la modificacion, sin preposicion) · de wijsvinger (el indice, el dedo que senala).

↔️ Los antonimos del par principal: toewijzen (asignar, conceder) ↔ afwijzen (denegar), y sus sustantivos de toewijzing ↔ de afwijzing.',
    updated_at = datetime('now')
WHERE id = 846
  AND rules_help IS NULL;

-- ==============================================================================
-- 6. Tarjeta 847: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'Aqui aanwijzen va sin preposicion ninguna: es transitivo y el objeto (een leerling) va directo. Lo que viene detras, om te antwoorden, no es regimen del verbo sino una final: «para responder». No confundir una cosa con la otra, que es de lo que mas despista. Los sustantivos: de leraar (el profesor), de leerling (el alumno).

🧲 Las preposiciones fijas de la familia de wijzen
En neerlandes la preposicion es PARTE del verbo: no se aprende «wijzen» sino «wijzen op». Cambiarla cambia el significado, y ninguna se deduce del espanol, asi que hay que aprenderlas pegadas al verbo, como una sola pieza.

| verbo | rige | que significa con esa preposicion | ejemplo |
|---|---|---|---|
| **toewijzen aan** | aan | asignar o adjudicar algo A alguien | Een budget toewijzen **aan** het project. |
| **wijzen op** | op | advertir de algo, llamar la atencion sobre | Ik wijs je **op** het risico. |
| **wijzen naar** | naar | apuntar hacia, con el dedo | Hij wees **naar** de deur. |
| **verwijzen naar** | naar | remitir a, hacer referencia a | De dokter verwijst me **naar** een specialist. |
| **aanwijzen als** | als | designar como, nombrar | Hij is aangewezen **als** teamleider. |
| **uitwijzen naar** | naar | deportar a un pais, en sentido legal | Ze werden uitgewezen **naar** hun land. |
| **wijzigen in / naar** | in, naar | cambiar una cosa POR otra | De afspraak wijzigen **naar** volgende week. |

⚠️ Y las que NO rigen ninguna, que tambien hay que saberlo: afwijzen, aanwijzen y uitwijzen (en su sentido de demostrar) son transitivos pelados, con objeto directo y sin preposicion detras. De bank wijst de aanvraag af. · De tijd zal het uitwijzen.

🔄 toewijzen tiene DOS construcciones, igual que geven:
• con aan = cuando el destinatario es largo, nuevo o va destacado, y entonces se va al final. De gemeente heeft een budget toegewezen aan het project.
• sin aan = cuando el destinatario es un pronombre, que va delante y pegado. De steward wijst je een stoel toe.
Lo decide la regla de peso: lo ligero y ya sabido delante, lo pesado y nuevo al final.

🧩 Cuando el objeto de la preposicion NO es un sustantivo, la preposicion se pega a ER y se coloca sola en la frase: Ik wijs je EROP dat het risico groot is. — Te advierto de que el riesgo es grande. Igual con daarop y waarop. Esto es lo que hace que la preposicion parezca desaparecer al oido.

🔤 Los sustantivos de la familia, con su articulo y su preposicion: de toewijzing aan (la asignacion) · de afwijzing van (la denegacion de) · de verwijzing naar (la remision a) · de aanwijzing voor (el indicio de) · de wijziging (la modificacion, sin preposicion) · de wijsvinger (el indice, el dedo que senala).

↔️ Los antonimos del par principal: toewijzen (asignar, conceder) ↔ afwijzen (denegar), y sus sustantivos de toewijzing ↔ de afwijzing.',
    updated_at = datetime('now')
WHERE id = 847
  AND rules_help IS NULL;

-- ==============================================================================
-- 7. Tarjeta 849: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'afwijzen es transitivo y NO rige preposicion: el objeto va directo, de aanvraag. Es el antonimo exacto de toewijzen (que si rige aan) y de goedkeuren: De bank wijst de aanvraag af. ↔ De bank keurt de aanvraag goed. Los sustantivos: de bank, de aanvraag (la solicitud), de afwijzing van (la denegacion de).

🧲 Las preposiciones fijas de la familia de wijzen
En neerlandes la preposicion es PARTE del verbo: no se aprende «wijzen» sino «wijzen op». Cambiarla cambia el significado, y ninguna se deduce del espanol, asi que hay que aprenderlas pegadas al verbo, como una sola pieza.

| verbo | rige | que significa con esa preposicion | ejemplo |
|---|---|---|---|
| **toewijzen aan** | aan | asignar o adjudicar algo A alguien | Een budget toewijzen **aan** het project. |
| **wijzen op** | op | advertir de algo, llamar la atencion sobre | Ik wijs je **op** het risico. |
| **wijzen naar** | naar | apuntar hacia, con el dedo | Hij wees **naar** de deur. |
| **verwijzen naar** | naar | remitir a, hacer referencia a | De dokter verwijst me **naar** een specialist. |
| **aanwijzen als** | als | designar como, nombrar | Hij is aangewezen **als** teamleider. |
| **uitwijzen naar** | naar | deportar a un pais, en sentido legal | Ze werden uitgewezen **naar** hun land. |
| **wijzigen in / naar** | in, naar | cambiar una cosa POR otra | De afspraak wijzigen **naar** volgende week. |

⚠️ Y las que NO rigen ninguna, que tambien hay que saberlo: afwijzen, aanwijzen y uitwijzen (en su sentido de demostrar) son transitivos pelados, con objeto directo y sin preposicion detras. De bank wijst de aanvraag af. · De tijd zal het uitwijzen.

🔄 toewijzen tiene DOS construcciones, igual que geven:
• con aan = cuando el destinatario es largo, nuevo o va destacado, y entonces se va al final. De gemeente heeft een budget toegewezen aan het project.
• sin aan = cuando el destinatario es un pronombre, que va delante y pegado. De steward wijst je een stoel toe.
Lo decide la regla de peso: lo ligero y ya sabido delante, lo pesado y nuevo al final.

🧩 Cuando el objeto de la preposicion NO es un sustantivo, la preposicion se pega a ER y se coloca sola en la frase: Ik wijs je EROP dat het risico groot is. — Te advierto de que el riesgo es grande. Igual con daarop y waarop. Esto es lo que hace que la preposicion parezca desaparecer al oido.

🔤 Los sustantivos de la familia, con su articulo y su preposicion: de toewijzing aan (la asignacion) · de afwijzing van (la denegacion de) · de verwijzing naar (la remision a) · de aanwijzing voor (el indicio de) · de wijziging (la modificacion, sin preposicion) · de wijsvinger (el indice, el dedo que senala).

↔️ Los antonimos del par principal: toewijzen (asignar, conceder) ↔ afwijzen (denegar), y sus sustantivos de toewijzing ↔ de afwijzing.',
    updated_at = datetime('now')
WHERE id = 849
  AND rules_help IS NULL;

-- ==============================================================================
-- 8. Tarjeta 850: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'Otra vez afwijzen transitivo y sin preposicion. Lo que hay que fijar aqui es el genero, que decide todo lo demas: het visum es het-woord (het visum, mijn visum, het afgewezen visum), plural de visa. Participio afgewezen, con el ge- en medio por ser af- separable. Antonimo: toekennen (conceder), het visum werd toegekend.

🧲 Las preposiciones fijas de la familia de wijzen
En neerlandes la preposicion es PARTE del verbo: no se aprende «wijzen» sino «wijzen op». Cambiarla cambia el significado, y ninguna se deduce del espanol, asi que hay que aprenderlas pegadas al verbo, como una sola pieza.

| verbo | rige | que significa con esa preposicion | ejemplo |
|---|---|---|---|
| **toewijzen aan** | aan | asignar o adjudicar algo A alguien | Een budget toewijzen **aan** het project. |
| **wijzen op** | op | advertir de algo, llamar la atencion sobre | Ik wijs je **op** het risico. |
| **wijzen naar** | naar | apuntar hacia, con el dedo | Hij wees **naar** de deur. |
| **verwijzen naar** | naar | remitir a, hacer referencia a | De dokter verwijst me **naar** een specialist. |
| **aanwijzen als** | als | designar como, nombrar | Hij is aangewezen **als** teamleider. |
| **uitwijzen naar** | naar | deportar a un pais, en sentido legal | Ze werden uitgewezen **naar** hun land. |
| **wijzigen in / naar** | in, naar | cambiar una cosa POR otra | De afspraak wijzigen **naar** volgende week. |

⚠️ Y las que NO rigen ninguna, que tambien hay que saberlo: afwijzen, aanwijzen y uitwijzen (en su sentido de demostrar) son transitivos pelados, con objeto directo y sin preposicion detras. De bank wijst de aanvraag af. · De tijd zal het uitwijzen.

🔄 toewijzen tiene DOS construcciones, igual que geven:
• con aan = cuando el destinatario es largo, nuevo o va destacado, y entonces se va al final. De gemeente heeft een budget toegewezen aan het project.
• sin aan = cuando el destinatario es un pronombre, que va delante y pegado. De steward wijst je een stoel toe.
Lo decide la regla de peso: lo ligero y ya sabido delante, lo pesado y nuevo al final.

🧩 Cuando el objeto de la preposicion NO es un sustantivo, la preposicion se pega a ER y se coloca sola en la frase: Ik wijs je EROP dat het risico groot is. — Te advierto de que el riesgo es grande. Igual con daarop y waarop. Esto es lo que hace que la preposicion parezca desaparecer al oido.

🔤 Los sustantivos de la familia, con su articulo y su preposicion: de toewijzing aan (la asignacion) · de afwijzing van (la denegacion de) · de verwijzing naar (la remision a) · de aanwijzing voor (el indicio de) · de wijziging (la modificacion, sin preposicion) · de wijsvinger (el indice, el dedo que senala).

↔️ Los antonimos del par principal: toewijzen (asignar, conceder) ↔ afwijzen (denegar), y sus sustantivos de toewijzing ↔ de afwijzing.',
    updated_at = datetime('now')
WHERE id = 850
  AND rules_help IS NULL;

-- ==============================================================================
-- 9. Tarjeta 852: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'El sustantivo tambien tiene preposicion fija, y no es la misma que la del verbo: de afwijzing VAN, que marca de quien viene la negativa. El verbo afwijzen no rige nada, pero de afwijzing van la universiteit si. Los sustantivos: de afwijzing van (la denegacion de), de universiteit. Antonimo: de toelating (la admision), de goedkeuring (la aprobacion).

🧲 Las preposiciones fijas de la familia de wijzen
En neerlandes la preposicion es PARTE del verbo: no se aprende «wijzen» sino «wijzen op». Cambiarla cambia el significado, y ninguna se deduce del espanol, asi que hay que aprenderlas pegadas al verbo, como una sola pieza.

| verbo | rige | que significa con esa preposicion | ejemplo |
|---|---|---|---|
| **toewijzen aan** | aan | asignar o adjudicar algo A alguien | Een budget toewijzen **aan** het project. |
| **wijzen op** | op | advertir de algo, llamar la atencion sobre | Ik wijs je **op** het risico. |
| **wijzen naar** | naar | apuntar hacia, con el dedo | Hij wees **naar** de deur. |
| **verwijzen naar** | naar | remitir a, hacer referencia a | De dokter verwijst me **naar** een specialist. |
| **aanwijzen als** | als | designar como, nombrar | Hij is aangewezen **als** teamleider. |
| **uitwijzen naar** | naar | deportar a un pais, en sentido legal | Ze werden uitgewezen **naar** hun land. |
| **wijzigen in / naar** | in, naar | cambiar una cosa POR otra | De afspraak wijzigen **naar** volgende week. |

⚠️ Y las que NO rigen ninguna, que tambien hay que saberlo: afwijzen, aanwijzen y uitwijzen (en su sentido de demostrar) son transitivos pelados, con objeto directo y sin preposicion detras. De bank wijst de aanvraag af. · De tijd zal het uitwijzen.

🔄 toewijzen tiene DOS construcciones, igual que geven:
• con aan = cuando el destinatario es largo, nuevo o va destacado, y entonces se va al final. De gemeente heeft een budget toegewezen aan het project.
• sin aan = cuando el destinatario es un pronombre, que va delante y pegado. De steward wijst je een stoel toe.
Lo decide la regla de peso: lo ligero y ya sabido delante, lo pesado y nuevo al final.

🧩 Cuando el objeto de la preposicion NO es un sustantivo, la preposicion se pega a ER y se coloca sola en la frase: Ik wijs je EROP dat het risico groot is. — Te advierto de que el riesgo es grande. Igual con daarop y waarop. Esto es lo que hace que la preposicion parezca desaparecer al oido.

🔤 Los sustantivos de la familia, con su articulo y su preposicion: de toewijzing aan (la asignacion) · de afwijzing van (la denegacion de) · de verwijzing naar (la remision a) · de aanwijzing voor (el indicio de) · de wijziging (la modificacion, sin preposicion) · de wijsvinger (el indice, el dedo que senala).

↔️ Los antonimos del par principal: toewijzen (asignar, conceder) ↔ afwijzen (denegar), y sus sustantivos de toewijzing ↔ de afwijzing.',
    updated_at = datetime('now')
WHERE id = 852
  AND rules_help IS NULL;

-- ==============================================================================
-- 10. Tarjeta 853: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'de afwijzing otra vez, aqui contada como suceso repetible (la tercera). Y de propina el verbo de la frase, que tiene su propia estructura: de moed opgeven = rendirse, separable (geeft de moed op, gaf op, opgegeven) y sin preposicion. Los sustantivos: de afwijzing van, de moed (el animo, el valor). Antonimo: volhouden (aguantar, no rendirse).

🧲 Las preposiciones fijas de la familia de wijzen
En neerlandes la preposicion es PARTE del verbo: no se aprende «wijzen» sino «wijzen op». Cambiarla cambia el significado, y ninguna se deduce del espanol, asi que hay que aprenderlas pegadas al verbo, como una sola pieza.

| verbo | rige | que significa con esa preposicion | ejemplo |
|---|---|---|---|
| **toewijzen aan** | aan | asignar o adjudicar algo A alguien | Een budget toewijzen **aan** het project. |
| **wijzen op** | op | advertir de algo, llamar la atencion sobre | Ik wijs je **op** het risico. |
| **wijzen naar** | naar | apuntar hacia, con el dedo | Hij wees **naar** de deur. |
| **verwijzen naar** | naar | remitir a, hacer referencia a | De dokter verwijst me **naar** een specialist. |
| **aanwijzen als** | als | designar como, nombrar | Hij is aangewezen **als** teamleider. |
| **uitwijzen naar** | naar | deportar a un pais, en sentido legal | Ze werden uitgewezen **naar** hun land. |
| **wijzigen in / naar** | in, naar | cambiar una cosa POR otra | De afspraak wijzigen **naar** volgende week. |

⚠️ Y las que NO rigen ninguna, que tambien hay que saberlo: afwijzen, aanwijzen y uitwijzen (en su sentido de demostrar) son transitivos pelados, con objeto directo y sin preposicion detras. De bank wijst de aanvraag af. · De tijd zal het uitwijzen.

🔄 toewijzen tiene DOS construcciones, igual que geven:
• con aan = cuando el destinatario es largo, nuevo o va destacado, y entonces se va al final. De gemeente heeft een budget toegewezen aan het project.
• sin aan = cuando el destinatario es un pronombre, que va delante y pegado. De steward wijst je een stoel toe.
Lo decide la regla de peso: lo ligero y ya sabido delante, lo pesado y nuevo al final.

🧩 Cuando el objeto de la preposicion NO es un sustantivo, la preposicion se pega a ER y se coloca sola en la frase: Ik wijs je EROP dat het risico groot is. — Te advierto de que el riesgo es grande. Igual con daarop y waarop. Esto es lo que hace que la preposicion parezca desaparecer al oido.

🔤 Los sustantivos de la familia, con su articulo y su preposicion: de toewijzing aan (la asignacion) · de afwijzing van (la denegacion de) · de verwijzing naar (la remision a) · de aanwijzing voor (el indicio de) · de wijziging (la modificacion, sin preposicion) · de wijsvinger (el indice, el dedo que senala).

↔️ Los antonimos del par principal: toewijzen (asignar, conceder) ↔ afwijzen (denegar), y sus sustantivos de toewijzing ↔ de afwijzing.',
    updated_at = datetime('now')
WHERE id = 853
  AND rules_help IS NULL;

-- ==============================================================================
-- 11. Tarjeta 855: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'verwijzen NAAR, nunca aan: es la preposicion fija que hay que aprender pegada al verbo. En jerga medica se usa mas doorverwijzen naar, que es exactamente lo mismo con la particula door- subrayando el paso de un profesional a otro. verwijzen es fuerte e inseparable (verwijst, verwees, verwezen) y su participio no lleva ge-. Los sustantivos: de dokter, de specialist, de verwijzing naar (la remision a), de verwijsbrief (el volante).

🧲 Las preposiciones fijas de la familia de wijzen
En neerlandes la preposicion es PARTE del verbo: no se aprende «wijzen» sino «wijzen op». Cambiarla cambia el significado, y ninguna se deduce del espanol, asi que hay que aprenderlas pegadas al verbo, como una sola pieza.

| verbo | rige | que significa con esa preposicion | ejemplo |
|---|---|---|---|
| **toewijzen aan** | aan | asignar o adjudicar algo A alguien | Een budget toewijzen **aan** het project. |
| **wijzen op** | op | advertir de algo, llamar la atencion sobre | Ik wijs je **op** het risico. |
| **wijzen naar** | naar | apuntar hacia, con el dedo | Hij wees **naar** de deur. |
| **verwijzen naar** | naar | remitir a, hacer referencia a | De dokter verwijst me **naar** een specialist. |
| **aanwijzen als** | als | designar como, nombrar | Hij is aangewezen **als** teamleider. |
| **uitwijzen naar** | naar | deportar a un pais, en sentido legal | Ze werden uitgewezen **naar** hun land. |
| **wijzigen in / naar** | in, naar | cambiar una cosa POR otra | De afspraak wijzigen **naar** volgende week. |

⚠️ Y las que NO rigen ninguna, que tambien hay que saberlo: afwijzen, aanwijzen y uitwijzen (en su sentido de demostrar) son transitivos pelados, con objeto directo y sin preposicion detras. De bank wijst de aanvraag af. · De tijd zal het uitwijzen.

🔄 toewijzen tiene DOS construcciones, igual que geven:
• con aan = cuando el destinatario es largo, nuevo o va destacado, y entonces se va al final. De gemeente heeft een budget toegewezen aan het project.
• sin aan = cuando el destinatario es un pronombre, que va delante y pegado. De steward wijst je een stoel toe.
Lo decide la regla de peso: lo ligero y ya sabido delante, lo pesado y nuevo al final.

🧩 Cuando el objeto de la preposicion NO es un sustantivo, la preposicion se pega a ER y se coloca sola en la frase: Ik wijs je EROP dat het risico groot is. — Te advierto de que el riesgo es grande. Igual con daarop y waarop. Esto es lo que hace que la preposicion parezca desaparecer al oido.

🔤 Los sustantivos de la familia, con su articulo y su preposicion: de toewijzing aan (la asignacion) · de afwijzing van (la denegacion de) · de verwijzing naar (la remision a) · de aanwijzing voor (el indicio de) · de wijziging (la modificacion, sin preposicion) · de wijsvinger (el indice, el dedo que senala).

↔️ Los antonimos del par principal: toewijzen (asignar, conceder) ↔ afwijzen (denegar), y sus sustantivos de toewijzing ↔ de afwijzing.',
    updated_at = datetime('now')
WHERE id = 855
  AND rules_help IS NULL;

-- ==============================================================================
-- 12. Tarjeta 858: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'uitwijzen en su sentido de demostrar o revelar es transitivo y sin preposicion: el objeto va directo, aqui el pronombre het. La frase es ademas una expresion hecha, De tijd zal het uitwijzen = el tiempo lo dira. Cuidado con la otra vida del verbo, la legal, que si rige preposicion: iemand uitwijzen NAAR zijn land (deportar a alguien a su pais). Los sustantivos: de tijd, de uitwijzing (la expulsion).

🧲 Las preposiciones fijas de la familia de wijzen
En neerlandes la preposicion es PARTE del verbo: no se aprende «wijzen» sino «wijzen op». Cambiarla cambia el significado, y ninguna se deduce del espanol, asi que hay que aprenderlas pegadas al verbo, como una sola pieza.

| verbo | rige | que significa con esa preposicion | ejemplo |
|---|---|---|---|
| **toewijzen aan** | aan | asignar o adjudicar algo A alguien | Een budget toewijzen **aan** het project. |
| **wijzen op** | op | advertir de algo, llamar la atencion sobre | Ik wijs je **op** het risico. |
| **wijzen naar** | naar | apuntar hacia, con el dedo | Hij wees **naar** de deur. |
| **verwijzen naar** | naar | remitir a, hacer referencia a | De dokter verwijst me **naar** een specialist. |
| **aanwijzen als** | als | designar como, nombrar | Hij is aangewezen **als** teamleider. |
| **uitwijzen naar** | naar | deportar a un pais, en sentido legal | Ze werden uitgewezen **naar** hun land. |
| **wijzigen in / naar** | in, naar | cambiar una cosa POR otra | De afspraak wijzigen **naar** volgende week. |

⚠️ Y las que NO rigen ninguna, que tambien hay que saberlo: afwijzen, aanwijzen y uitwijzen (en su sentido de demostrar) son transitivos pelados, con objeto directo y sin preposicion detras. De bank wijst de aanvraag af. · De tijd zal het uitwijzen.

🔄 toewijzen tiene DOS construcciones, igual que geven:
• con aan = cuando el destinatario es largo, nuevo o va destacado, y entonces se va al final. De gemeente heeft een budget toegewezen aan het project.
• sin aan = cuando el destinatario es un pronombre, que va delante y pegado. De steward wijst je een stoel toe.
Lo decide la regla de peso: lo ligero y ya sabido delante, lo pesado y nuevo al final.

🧩 Cuando el objeto de la preposicion NO es un sustantivo, la preposicion se pega a ER y se coloca sola en la frase: Ik wijs je EROP dat het risico groot is. — Te advierto de que el riesgo es grande. Igual con daarop y waarop. Esto es lo que hace que la preposicion parezca desaparecer al oido.

🔤 Los sustantivos de la familia, con su articulo y su preposicion: de toewijzing aan (la asignacion) · de afwijzing van (la denegacion de) · de verwijzing naar (la remision a) · de aanwijzing voor (el indicio de) · de wijziging (la modificacion, sin preposicion) · de wijsvinger (el indice, el dedo que senala).

↔️ Los antonimos del par principal: toewijzen (asignar, conceder) ↔ afwijzen (denegar), y sus sustantivos de toewijzing ↔ de afwijzing.',
    updated_at = datetime('now')
WHERE id = 858
  AND rules_help IS NULL;

-- ==============================================================================
-- 13. Tarjeta 859: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'Aqui uitwijzen no lleva preposicion sino una subordinada con dat, que hace de objeto directo: heeft uitgewezen DAT het virus muteert. Es el patron normal de los verbos de demostrar y decir. Participio uitgewezen, con el ge- en medio por ser uit- separable. Los sustantivos: het onderzoek (la investigacion), het virus. Antonimo del resultado: weerleggen (refutar).

🧲 Las preposiciones fijas de la familia de wijzen
En neerlandes la preposicion es PARTE del verbo: no se aprende «wijzen» sino «wijzen op». Cambiarla cambia el significado, y ninguna se deduce del espanol, asi que hay que aprenderlas pegadas al verbo, como una sola pieza.

| verbo | rige | que significa con esa preposicion | ejemplo |
|---|---|---|---|
| **toewijzen aan** | aan | asignar o adjudicar algo A alguien | Een budget toewijzen **aan** het project. |
| **wijzen op** | op | advertir de algo, llamar la atencion sobre | Ik wijs je **op** het risico. |
| **wijzen naar** | naar | apuntar hacia, con el dedo | Hij wees **naar** de deur. |
| **verwijzen naar** | naar | remitir a, hacer referencia a | De dokter verwijst me **naar** een specialist. |
| **aanwijzen als** | als | designar como, nombrar | Hij is aangewezen **als** teamleider. |
| **uitwijzen naar** | naar | deportar a un pais, en sentido legal | Ze werden uitgewezen **naar** hun land. |
| **wijzigen in / naar** | in, naar | cambiar una cosa POR otra | De afspraak wijzigen **naar** volgende week. |

⚠️ Y las que NO rigen ninguna, que tambien hay que saberlo: afwijzen, aanwijzen y uitwijzen (en su sentido de demostrar) son transitivos pelados, con objeto directo y sin preposicion detras. De bank wijst de aanvraag af. · De tijd zal het uitwijzen.

🔄 toewijzen tiene DOS construcciones, igual que geven:
• con aan = cuando el destinatario es largo, nuevo o va destacado, y entonces se va al final. De gemeente heeft een budget toegewezen aan het project.
• sin aan = cuando el destinatario es un pronombre, que va delante y pegado. De steward wijst je een stoel toe.
Lo decide la regla de peso: lo ligero y ya sabido delante, lo pesado y nuevo al final.

🧩 Cuando el objeto de la preposicion NO es un sustantivo, la preposicion se pega a ER y se coloca sola en la frase: Ik wijs je EROP dat het risico groot is. — Te advierto de que el riesgo es grande. Igual con daarop y waarop. Esto es lo que hace que la preposicion parezca desaparecer al oido.

🔤 Los sustantivos de la familia, con su articulo y su preposicion: de toewijzing aan (la asignacion) · de afwijzing van (la denegacion de) · de verwijzing naar (la remision a) · de aanwijzing voor (el indicio de) · de wijziging (la modificacion, sin preposicion) · de wijsvinger (el indice, el dedo que senala).

↔️ Los antonimos del par principal: toewijzen (asignar, conceder) ↔ afwijzen (denegar), y sus sustantivos de toewijzing ↔ de afwijzing.',
    updated_at = datetime('now')
WHERE id = 859
  AND rules_help IS NULL;
