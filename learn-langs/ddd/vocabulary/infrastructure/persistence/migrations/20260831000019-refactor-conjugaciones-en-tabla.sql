-- Learn Languages App - Todas las conjugaciones en linea pasan a TABLA
-- Migration: 20260831000019-refactor-conjugaciones-en-tabla.sql
-- Description: Eduardo: «hagamos un refactor de las ayudas en la conjugacion en todas las ayudas,
--   tipo: presente - ik verwissel · jij/hij verwisselt · wij/jullie/zij verwisselen. pasado - …
--   llevalas a formato tabla, se lee mejor». Hasta ahora la conjugacion vivia en una linea
--   corrida (o en tres vinetas) y habia que leerla entera para encontrar una persona. Se pasan
--   TODAS al mismo formato de tabla que ya usaban willen (313) y verbergen (781/825/826):
--   siete personas en filas, presente e imperfecto en columnas, y debajo las vinetas del
--   participio con su auxiliar, la trampa de la -t en la inversion, el ge- dentro o fuera segun
--   el prefijo, y las preposiciones fijas.
--   Cubre 4 familias de bloques: (a) el de una sola linea «📐 Conjugacion: presente — …» de los
--   nueve verbos de wijzen/cambiar (842 wijzigen, 845 aanwijzen, 848 afwijzen, 854 verwijzen,
--   857 uitwijzen, 860 veranderen, 863 wisselen, 866 verwisselen, 869 omzetten); (b) el de tres
--   vinetas «📐 Conjugacion de X:» (812 schijnen, 814 zetten, 818 uitleggen, 821 afvallen,
--   834 toewijzen); (c) los reflexivos, donde el pronombre cambia con la persona y por eso la
--   tabla se lee todavia mejor (603 zich schamen, 606 zich ontspannen) y el irregular roepen
--   (554); y (d) zullen, que estaba repartido en dos listas compartidas — futuro en 12 tarjetas
--   (525-536) y condicional en 9 (537-545), mas la linea suelta de la 206 —: las tres reciben
--   AHORA LA MISMA tabla, con futuro y condicional en columnas, para que zal y zou se vean de un
--   vistazo como lo que son, el mismo verbo.
--   Se hace con REPLACE del texto exacto, asi que es idempotente: al aplicarse desaparece el
--   texto viejo y una segunda pasada no encuentra nada que cambiar.

-- 1. wijzigen (1 tarjeta(s): 842)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '📐 Conjugacion: presente — ik wijzig · jij/hij wijzigt · wij/jullie/zij wijzigen. pasado — ik/jij/hij wijzigde · wij/jullie/zij wijzigden. participio — gewijzigd (heeft gewijzigd).', '
📐 Conjugacion de wijzigen (debil y regular, no separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | wijzig | wijzigde |
| jij / je | wijzigt | wijzigde |
| u | wijzigt | wijzigde |
| hij / zij / het | wijzigt | wijzigde |
| wij | wijzigen | wijzigden |
| jullie | wijzigen | wijzigden |
| zij (plural) | wijzigen | wijzigden |

• participio — gewijzigd, con hebben: De wet is gewijzigd · Ik heb de datum gewijzigd.
• al invertir, jij pierde la -t: Wijzig jij de datum? — no «wijzigt jij».
• el sustantivo — de wijziging (la modificacion, el cambio): een wijziging doorvoeren.
'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '📐 Conjugacion: presente — ik wijzig · jij/hij wijzigt · wij/jullie/zij wijzigen. pasado — ik/jij/hij wijzigde · wij/jullie/zij wijzigden. participio — gewijzigd (heeft gewijzigd).' || '%';

-- 2. aanwijzen (1 tarjeta(s): 845)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '📐 Conjugacion: presente — ik wijs aan · jij/hij wijst aan · wij/jullie/zij wijzen aan. pasado — ik/jij/hij wees aan · wij/jullie/zij wezen aan. participio — aangewezen (heeft aangewezen).', '
📐 Conjugacion de aanwijzen (fuerte y separable: aan + wijzen):

| persona | presente | imperfecto |
|---|---|---|
| ik | wijs aan | wees aan |
| jij / je | wijst aan | wees aan |
| u | wijst aan | wees aan |
| hij / zij / het | wijst aan | wees aan |
| wij | wijzen aan | wezen aan |
| jullie | wijzen aan | wezen aan |
| zij (plural) | wijzen aan | wezen aan |

• participio — aangewezen, con hebben, y el ge- va DENTRO (aan-ge-wezen): Hij heeft de dader aangewezen.
• en subordinada las dos piezas se reunen: … omdat hij de dader aanwijst.
• al invertir, jij pierde la -t: Wijs jij hem aan? — no «wijst jij».
'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '📐 Conjugacion: presente — ik wijs aan · jij/hij wijst aan · wij/jullie/zij wijzen aan. pasado — ik/jij/hij wees aan · wij/jullie/zij wezen aan. participio — aangewezen (heeft aangewezen).' || '%';

-- 3. afwijzen (1 tarjeta(s): 848)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '📐 Conjugacion: presente — ik wijs af · jij/hij wijst af · wij/jullie/zij wijzen af. pasado — ik/jij/hij wees af · wij/jullie/zij wezen af. participio — afgewezen (heeft afgewezen).', '
📐 Conjugacion de afwijzen (fuerte y separable: af + wijzen):

| persona | presente | imperfecto |
|---|---|---|
| ik | wijs af | wees af |
| jij / je | wijst af | wees af |
| u | wijst af | wees af |
| hij / zij / het | wijst af | wees af |
| wij | wijzen af | wezen af |
| jullie | wijzen af | wezen af |
| zij (plural) | wijzen af | wezen af |

• participio — afgewezen, con hebben, con el ge- DENTRO (af-ge-wezen): Ze hebben mijn visum afgewezen.
• en subordinada las piezas se juntan: … omdat de bank de aanvraag afwijst.
• el sustantivo — de afwijzing (la denegacion, el rechazo). Antonimo: goedkeuren / toewijzen (conceder).
'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '📐 Conjugacion: presente — ik wijs af · jij/hij wijst af · wij/jullie/zij wijzen af. pasado — ik/jij/hij wees af · wij/jullie/zij wezen af. participio — afgewezen (heeft afgewezen).' || '%';

-- 4. verwijzen (1 tarjeta(s): 854)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '📐 Conjugacion: presente — ik verwijs · jij/hij verwijst · wij/jullie/zij verwijzen. pasado — ik/jij/hij verwees · wij/jullie/zij verwezen. participio — verwezen (heeft verwezen, sin ge-).', '
📐 Conjugacion de verwijzen (fuerte, prefijo ver- INSEPARABLE):

| persona | presente | imperfecto |
|---|---|---|
| ik | verwijs | verwees |
| jij / je | verwijst | verwees |
| u | verwijst | verwees |
| hij / zij / het | verwijst | verwees |
| wij | verwijzen | verwezen |
| jullie | verwijzen | verwezen |
| zij (plural) | verwijzen | verwezen |

• participio — verwezen, con hebben y SIN ge-, porque ver- es prefijo atono inseparable: De dokter heeft me verwezen naar een specialist.
• ojo — verwezen es a la vez el participio y el imperfecto plural (wij verwezen). Lo distingue el auxiliar: We verwezen hem (pasado) · We hebben hem verwezen (perfecto).
• preposicion fija — verwijzen NAAR, nunca aan: verwijzen naar een specialist, naar een artikel.
'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '📐 Conjugacion: presente — ik verwijs · jij/hij verwijst · wij/jullie/zij verwijzen. pasado — ik/jij/hij verwees · wij/jullie/zij verwezen. participio — verwezen (heeft verwezen, sin ge-).' || '%';

-- 5. uitwijzen (1 tarjeta(s): 857)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '📐 Conjugacion: presente — ik wijs uit · jij/hij wijst uit · wij/jullie/zij wijzen uit. pasado — ik/jij/hij wees uit · wij/jullie/zij wezen uit. participio — uitgewezen (heeft uitgewezen).', '
📐 Conjugacion de uitwijzen (fuerte y separable: uit + wijzen):

| persona | presente | imperfecto |
|---|---|---|
| ik | wijs uit | wees uit |
| jij / je | wijst uit | wees uit |
| u | wijst uit | wees uit |
| hij / zij / het | wijst uit | wees uit |
| wij | wijzen uit | wezen uit |
| jullie | wijzen uit | wezen uit |
| zij (plural) | wijzen uit | wezen uit |

• participio — uitgewezen, con hebben y el ge- DENTRO (uit-ge-wezen): Het onderzoek heeft uitgewezen dat…
• en subordinada las piezas se juntan: … omdat het onderzoek dat uitwijst.
• frase hecha — De tijd zal het uitwijzen. — El tiempo lo dira.
'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '📐 Conjugacion: presente — ik wijs uit · jij/hij wijst uit · wij/jullie/zij wijzen uit. pasado — ik/jij/hij wees uit · wij/jullie/zij wezen uit. participio — uitgewezen (heeft uitgewezen).' || '%';

-- 6. veranderen (1 tarjeta(s): 860)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '📐 Conjugacion: presente — ik verander · jij/hij verandert · wij/jullie/zij veranderen. pasado — ik/jij/hij veranderde · wij/jullie/zij veranderden. participio — veranderd (is veranderd si es un cambio de estado — Het weer is veranderd; heeft veranderd si cambias algo tu — Ik heb mijn mening veranderd).', '
📐 Conjugacion de veranderen (debil y regular, prefijo ver- inseparable):

| persona | presente | imperfecto |
|---|---|---|
| ik | verander | veranderde |
| jij / je | verandert | veranderde |
| u | verandert | veranderde |
| hij / zij / het | verandert | veranderde |
| wij | veranderen | veranderden |
| jullie | veranderen | veranderden |
| zij (plural) | veranderen | veranderden |

• participio — veranderd, SIN ge- (ver- inseparable), y con DOS auxiliares segun el sentido: is veranderd cuando algo se vuelve distinto solo (Het weer is veranderd) · heeft veranderd cuando tu cambias algo (Ik heb mijn mening veranderd).
• preposiciones — veranderen VAN (cambiar de: van baan, van gedachten) · veranderen IN (convertirse en: De prins veranderde in een kikker).
• el sustantivo — de verandering (el cambio): een verandering doormaken.'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '📐 Conjugacion: presente — ik verander · jij/hij verandert · wij/jullie/zij veranderen. pasado — ik/jij/hij veranderde · wij/jullie/zij veranderden. participio — veranderd (is veranderd si es un cambio de estado — Het weer is veranderd; heeft veranderd si cambias algo tu — Ik heb mijn mening veranderd).' || '%';

-- 7. wisselen (1 tarjeta(s): 863)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '📐 Conjugacion: presente — ik wissel · jij/hij wisselt · wij/jullie/zij wisselen. pasado — ik/jij/hij wisselde · wij/jullie/zij wisselden. participio — gewisseld (heeft gewisseld).', '
📐 Conjugacion de wisselen (debil y regular, no separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | wissel | wisselde |
| jij / je | wisselt | wisselde |
| u | wisselt | wisselde |
| hij / zij / het | wisselt | wisselde |
| wij | wisselen | wisselden |
| jullie | wisselen | wisselden |
| zij (plural) | wisselen | wisselden |

• participio — gewisseld, con hebben y CON ge-, porque no lleva prefijo inseparable: Ik heb geld gewisseld.
• preposiciones — wisselen VAN (cambiar de: van plaats, van baan) · wisselen VOOR (cambiar por: euro''s voor dollars).
• el sustantivo — het wisselgeld (el cambio, las vueltas) · de wisseling (el relevo, el cambio de turno).'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '📐 Conjugacion: presente — ik wissel · jij/hij wisselt · wij/jullie/zij wisselen. pasado — ik/jij/hij wisselde · wij/jullie/zij wisselden. participio — gewisseld (heeft gewisseld).' || '%';

-- 8. verwisselen (1 tarjeta(s): 866)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '📐 Conjugacion: presente — ik verwissel · jij/hij verwisselt · wij/jullie/zij verwisselen. pasado — ik/jij/hij verwisselde · wij/jullie/zij verwisselden. participio — verwisseld (heeft verwisseld, sin ge-).', '
📐 Conjugacion de verwisselen (debil y regular, prefijo ver- INSEPARABLE):

| persona | presente | imperfecto |
|---|---|---|
| ik | verwissel | verwisselde |
| jij / je | verwisselt | verwisselde |
| u | verwisselt | verwisselde |
| hij / zij / het | verwisselt | verwisselde |
| wij | verwisselen | verwisselden |
| jullie | verwisselen | verwisselden |
| zij (plural) | verwisselen | verwisselden |

• participio — verwisseld, con hebben y SIN ge-, porque ver- es prefijo atono inseparable: Ik heb de sleutels verwisseld.
• al invertir, jij pierde la -t: Verwissel jij de banden? — no «verwisselt jij».
• preposicion — verwisselen MET (confundir con): Ik verwissel je altijd met je broer.'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '📐 Conjugacion: presente — ik verwissel · jij/hij verwisselt · wij/jullie/zij verwisselen. pasado — ik/jij/hij verwisselde · wij/jullie/zij verwisselden. participio — verwisseld (heeft verwisseld, sin ge-).' || '%';

-- 9. omzetten (1 tarjeta(s): 869)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '📐 Conjugacion: presente — ik zet om · jij/hij zet om · wij/jullie/zij zetten om. pasado — ik/jij/hij zette om · wij/jullie/zij zetten om. participio — omgezet (heeft omgezet).', '
📐 Conjugacion de omzetten (debil y separable: om + zetten):

| persona | presente | imperfecto |
|---|---|---|
| ik | zet om | zette om |
| jij / je | zet om | zette om |
| u | zet om | zette om |
| hij / zij / het | zet om | zette om |
| wij | zetten om | zetten om |
| jullie | zetten om | zetten om |
| zij (plural) | zetten om | zetten om |

• participio — omgezet, con hebben y el ge- DENTRO (om-ge-zet): Ik heb de graden omgezet naar Fahrenheit.
• ojo — la raiz ya acaba en -t (zet), asi que jij/hij NO anaden otra: hij zet om, nunca «zett om».
• y otro ojo — el presente plural (wij zetten om) y el imperfecto plural (wij zetten om) son IGUALES: lo decide el contexto o un marcador de tiempo (vroeger zetten we…).
• preposicion — omzetten IN o NAAR (convertir en/a): euro''s omzetten in dollars, een bestand omzetten naar pdf.'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '📐 Conjugacion: presente — ik zet om · jij/hij zet om · wij/jullie/zij zetten om. pasado — ik/jij/hij zette om · wij/jullie/zij zetten om. participio — omgezet (heeft omgezet).' || '%';

-- 10. schijnen (1 tarjeta(s): 812)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '• presente — ik schijn · jij/hij schijnt · wij/jullie/zij schijnen
• pasado (imperfecto) — ik/jij/hij scheen · wij/jullie/zij schenen
• participio — geschenen (heeft geschenen)', '
| persona | presente | imperfecto |
|---|---|---|
| ik | schijn | scheen |
| jij / je | schijnt | scheen |
| u | schijnt | scheen |
| hij / zij / het | schijnt | scheen |
| wij | schijnen | schenen |
| jullie | schijnen | schenen |
| zij (plural) | schijnen | schenen |

• participio — geschenen, con hebben: De zon heeft de hele dag geschenen.
• al invertir, jij pierde la -t: Schijn jij dat serieus te menen? — no «schijnt jij».
• ojo — el pasado es scheen / schenen, nunca «scheende»: es fuerte y cambia la vocal (ij → ee).'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '• presente — ik schijn · jij/hij schijnt · wij/jullie/zij schijnen
• pasado (imperfecto) — ik/jij/hij scheen · wij/jullie/zij schenen
• participio — geschenen (heeft geschenen)' || '%';

-- 11. zetten (1 tarjeta(s): 814)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '• presente — ik zet · jij/hij zet · wij/jullie/zij zetten
• pasado (imperfecto) — ik/jij/hij zette · wij/jullie/zij zetten
• participio — gezet (heeft gezet)', '
| persona | presente | imperfecto |
|---|---|---|
| ik | zet | zette |
| jij / je | zet | zette |
| u | zet | zette |
| hij / zij / het | zet | zette |
| wij | zetten | zetten |
| jullie | zetten | zetten |
| zij (plural) | zetten | zetten |

• participio — gezet, con hebben: Ik heb koffie gezet.
• ojo — la raiz ya acaba en -t (zet), asi que jij/hij NO anaden otra: hij zet, nunca «zett».
• y otro ojo — el presente plural (wij zetten) y el imperfecto plural (wij zetten) son la MISMA forma: lo decide el contexto (Vroeger zetten we hier de tent neer).'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '• presente — ik zet · jij/hij zet · wij/jullie/zij zetten
• pasado (imperfecto) — ik/jij/hij zette · wij/jullie/zij zetten
• participio — gezet (heeft gezet)' || '%';

-- 12. uitleggen (1 tarjeta(s): 818)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '• presente — ik leg uit · jij/hij legt uit · wij/jullie/zij leggen uit
• pasado (imperfecto) — ik/jij/hij legde uit · wij/jullie/zij legden uit
• participio — uitgelegd (heeft uitgelegd)', '
| persona | presente | imperfecto |
|---|---|---|
| ik | leg uit | legde uit |
| jij / je | legt uit | legde uit |
| u | legt uit | legde uit |
| hij / zij / het | legt uit | legde uit |
| wij | leggen uit | legden uit |
| jullie | leggen uit | legden uit |
| zij (plural) | leggen uit | legden uit |

• participio — uitgelegd, con hebben y el ge- DENTRO (uit-ge-legd): Heb je het al uitgelegd?
• en subordinada las dos piezas se reunen y se escriben juntas: … omdat hij het nogmaals uitlegt.
• al invertir, jij pierde la -t: Leg jij het even uit? — no «legt jij».'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '• presente — ik leg uit · jij/hij legt uit · wij/jullie/zij leggen uit
• pasado (imperfecto) — ik/jij/hij legde uit · wij/jullie/zij legden uit
• participio — uitgelegd (heeft uitgelegd)' || '%';

-- 13. afvallen (1 tarjeta(s): 821)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '• presente — ik val af · jij/hij valt af · wij/jullie/zij vallen af
• imperfecto (pasado) — ik/jij/hij viel af · wij/jullie/zij vielen af
• participio — afgevallen (is/ben afgevallen)', '
| persona | presente | imperfecto |
|---|---|---|
| ik | val af | viel af |
| jij / je | valt af | viel af |
| u | valt af | viel af |
| hij / zij / het | valt af | viel af |
| wij | vallen af | vielen af |
| jullie | vallen af | vielen af |
| zij (plural) | vallen af | vielen af |

• participio — afgevallen, con ZIJN (cambio de estado) y el ge- DENTRO (af-ge-vallen): Ik ben vijf kilo afgevallen.
• en subordinada las piezas se juntan: … omdat hij steeds meer afvalt.
• al invertir, jij pierde la -t: Val jij veel af? — no «valt jij».'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '• presente — ik val af · jij/hij valt af · wij/jullie/zij vallen af
• imperfecto (pasado) — ik/jij/hij viel af · wij/jullie/zij vielen af
• participio — afgevallen (is/ben afgevallen)' || '%';

-- 14. toewijzen (1 tarjeta(s): 834)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '• presente — ik wijs toe · jij/hij wijst toe · wij/jullie/zij wijzen toe
• pasado (imperfecto) — ik/jij/hij wees toe · wij/jullie/zij wezen toe
• participio — toegewezen (heeft toegewezen)', '
| persona | presente | imperfecto |
|---|---|---|
| ik | wijs toe | wees toe |
| jij / je | wijst toe | wees toe |
| u | wijst toe | wees toe |
| hij / zij / het | wijst toe | wees toe |
| wij | wijzen toe | wezen toe |
| jullie | wijzen toe | wezen toe |
| zij (plural) | wijzen toe | wezen toe |

• participio — toegewezen, con hebben y el ge- DENTRO (toe-ge-wezen): Ze hebben haar een huis toegewezen.
• en subordinada las piezas se juntan: … omdat de manager hem die taak toewijst.
• preposicion fija — toewijzen AAN: een budget toewijzen aan het project.'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '• presente — ik wijs toe · jij/hij wijst toe · wij/jullie/zij wijzen toe
• pasado (imperfecto) — ik/jij/hij wees toe · wij/jullie/zij wezen toe
• participio — toegewezen (heeft toegewezen)' || '%';

-- 15. roepen (1 tarjeta(s): 554)
UPDATE words_es
SET rules_help = REPLACE(rules_help, 'Roepen es irregular (fuerte):
• presente — ik roep · jij roept · hij roept · wij roepen
• pasado — riep (singular) · riepen (plural)
• participio — geroepen: Ik heb je geroepen = te he llamado.', 'Roepen es irregular (fuerte):

| persona | presente | imperfecto |
|---|---|---|
| ik | roep | riep |
| jij / je | roept | riep |
| u | roept | riep |
| hij / zij / het | roept | riep |
| wij | roepen | riepen |
| jullie | roepen | riepen |
| zij (plural) | roepen | riepen |

• participio — geroepen, con hebben: Ik heb je geroepen. — Te he llamado.
• al invertir, jij pierde la -t: Roep jij haar even? — no «roept jij».
• imperativo — Roep haar maar even! (tuteo) · Roept u maar! (cortesia).'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || 'Roepen es irregular (fuerte):
• presente — ik roep · jij roept · hij roept · wij roepen
• pasado — riep (singular) · riepen (plural)
• participio — geroepen: Ik heb je geroepen = te he llamado.' || '%';

-- 16. zich schamen (1 tarjeta(s): 603)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '• presente: ik schaam me · jij schaamt je (invertido: schaam jij je?) · u schaamt zich · hij/zij/het schaamt zich · wij schamen ons · jullie schamen je · zij schamen zich.
• imperfecto: ik schaamde me · jij schaamde je · wij schaamden ons.', '
| persona | presente | imperfecto |
|---|---|---|
| ik | schaam me | schaamde me |
| jij / je | schaamt je | schaamde je |
| u | schaamt zich | schaamde zich |
| hij / zij / het | schaamt zich | schaamde zich |
| wij | schamen ons | schaamden ons |
| jullie | schamen je | schaamden je |
| zij (plural) | schamen zich | schaamden zich |

• al invertir, jij pierde la -t pero conserva su reflexivo: Schaam jij je nooit? — u no la pierde nunca: Schaamt u zich?'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '• presente: ik schaam me · jij schaamt je (invertido: schaam jij je?) · u schaamt zich · hij/zij/het schaamt zich · wij schamen ons · jullie schamen je · zij schamen zich.
• imperfecto: ik schaamde me · jij schaamde je · wij schaamden ons.' || '%';

-- 17. zich ontspannen (1 tarjeta(s): 606)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '• presente: ik ontspan me · jij ontspant je (invertido: ontspan jij je?) · u ontspant zich · hij/zij/het ontspant zich · wij ontspannen ons · jullie ontspannen je · zij ontspannen zich. Ojo a la raíz: ontspannen → ontspan, con una sola n.
• imperfecto: ik ontspande me · jij ontspande je · wij ontspanden ons.', '
| persona | presente | imperfecto |
|---|---|---|
| ik | ontspan me | ontspande me |
| jij / je | ontspant je | ontspande je |
| u | ontspant zich | ontspande zich |
| hij / zij / het | ontspant zich | ontspande zich |
| wij | ontspannen ons | ontspanden ons |
| jullie | ontspannen je | ontspanden je |
| zij (plural) | ontspannen zich | ontspanden zich |

• ojo a la raíz: ontspannen → ontspan, con una sola n (y por eso el plural recupera las dos: ontspannen).
• al invertir, jij pierde la -t: ontspan jij je? — u no la pierde nunca: ontspant u zich?'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || '• presente: ik ontspan me · jij ontspant je (invertido: ontspan jij je?) · u ontspant zich · hij/zij/het ontspant zich · wij ontspannen ons · jullie ontspannen je · zij ontspannen zich. Ojo a la raíz: ontspannen → ontspan, con una sola n.
• imperfecto: ik ontspande me · jij ontspande je · wij ontspanden ons.' || '%';

-- 18. zullen (futuro) (12 tarjeta(s): 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536)
UPDATE words_es
SET rules_help = REPLACE(rules_help, 'Conjugación de zullen (futuro):
• ik zal — yo
• jij/je zult (o zal) — tú · en pregunta pierde la -t: zul jij?
• u zult — usted (formal)
• hij/zij/het zal — él/ella/ello
• wij/we zullen — nosotros
• jullie zullen — vosotros
• zij/ze zullen — ellos', 'Conjugación de zullen (futuro y condicional):

| persona | futuro (zal) | condicional (zou) |
|---|---|---|
| ik | zal | zou |
| jij / je | zult (o zal) | zou |
| u | zult | zou |
| hij / zij / het | zal | zou |
| wij / we | zullen | zouden |
| jullie | zullen | zouden |
| zij / ze (plural) | zullen | zouden |

• en pregunta o inversion, jij pierde la -t: zul jij? · zul je? — nunca «zult jij».
• zou y zouden valen para el condicional Y para el pasado de zullen; el infinitivo va siempre al final: Ik zou het niet doen.
• zullen no se usa en perfecto: el pasado se hace con el verbo principal (Ik heb het gedaan), nunca «Ik heb het zullen doen».'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || 'Conjugación de zullen (futuro):
• ik zal — yo
• jij/je zult (o zal) — tú · en pregunta pierde la -t: zul jij?
• u zult — usted (formal)
• hij/zij/het zal — él/ella/ello
• wij/we zullen — nosotros
• jullie zullen — vosotros
• zij/ze zullen — ellos' || '%';

-- 19. zullen (condicional) (9 tarjeta(s): 537, 538, 539, 540, 541, 542, 543, 544, 545)
UPDATE words_es
SET rules_help = REPLACE(rules_help, 'Conjugación de zullen en condicional (zou):
• ik/jij/u/hij/zij/het zou — singular (todos igual)
• wij/jullie/zij zouden — plural (todos igual)', 'Conjugación de zullen en condicional (zou):

| persona | futuro (zal) | condicional (zou) |
|---|---|---|
| ik | zal | zou |
| jij / je | zult (o zal) | zou |
| u | zult | zou |
| hij / zij / het | zal | zou |
| wij / we | zullen | zouden |
| jullie | zullen | zouden |
| zij / ze (plural) | zullen | zouden |

• el condicional es facil: zou en TODO el singular y zouden en TODO el plural.
• en pregunta o inversion, jij pierde la -t: zul jij? · zul je? — nunca «zult jij».
• zou y zouden valen para el condicional Y para el pasado de zullen; el infinitivo va siempre al final: Ik zou het niet doen.
• zullen no se usa en perfecto: el pasado se hace con el verbo principal (Ik heb het gedaan), nunca «Ik heb het zullen doen».'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || 'Conjugación de zullen en condicional (zou):
• ik/jij/u/hij/zij/het zou — singular (todos igual)
• wij/jullie/zij zouden — plural (todos igual)' || '%';

-- 20. zullen (206) (1 tarjeta(s): 206)
UPDATE words_es
SET rules_help = REPLACE(rules_help, 'Conjugación de zullen: ik zal, jij zult (¿zul je?), hij/zij zal, wij/jullie/zij zullen. Pasado: zou/zouden.', '
Conjugación de zullen (futuro y condicional):

| persona | futuro (zal) | condicional (zou) |
|---|---|---|
| ik | zal | zou |
| jij / je | zult (o zal) | zou |
| u | zult | zou |
| hij / zij / het | zal | zou |
| wij / we | zullen | zouden |
| jullie | zullen | zouden |
| zij / ze (plural) | zullen | zouden |

• en pregunta o inversion, jij pierde la -t: zul jij? · zul je? — nunca «zult jij».
• zou y zouden valen para el condicional Y para el pasado de zullen; el infinitivo va siempre al final: Ik zou het niet doen.
• zullen no se usa en perfecto: el pasado se hace con el verbo principal (Ik heb het gedaan), nunca «Ik heb het zullen doen».
'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%' || 'Conjugación de zullen: ik zal, jij zult (¿zul je?), hij/zij zal, wij/jullie/zij zullen. Pasado: zou/zouden.' || '%';
