BEGIN;

UPDATE typeface
SET name = 'Trigger update test'
WHERE id_typeface = (SELECT MIN(id_typeface) FROM typeface);

-- проверяем, что обновилось

SELECT *
FROM typeface_format_weight_stats
WHERE typeface_name = 'Trigger update test';

ROLLBACK;
