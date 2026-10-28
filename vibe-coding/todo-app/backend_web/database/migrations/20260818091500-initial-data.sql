-- 20260818091500-initial-data
--
-- Una lista por defecto, para que la aplicacion tenga algo que mostrar en el
-- primer arranque y para que la regla "una tarea pertenece a una lista" se pueda
-- probar sin crear nada antes.
--
-- El INSERT ... SELECT ... WHERE NOT EXISTS es el patron de insercion idempotente
-- de este proyecto: se puede ejecutar mil veces y solo inserta la primera. Se
-- usa esto en vez de ON CONFLICT porque ON CONFLICT exige nombrar un indice unico
-- concreto, y esto funciona igual sin acoplarse a el.
INSERT INTO app_lists (name, color, position)
SELECT 'Entrada', '#4F8EF7', 0
WHERE NOT EXISTS (SELECT 1 FROM app_lists WHERE lower(name) = 'entrada');
