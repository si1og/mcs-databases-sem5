BEGIN;

INSERT INTO typeface (
    name,
    id_weight,
    id_slope,
    file_size,
    id_font_family,
    id_format
)
SELECT
    'Trigger insert test',
    id_weight,
    id_slope,
    file_size,
    id_font_family,
    id_format
FROM typeface
ORDER BY id_typeface
LIMIT 1;

-- проверяем, что вставилось

SELECT *
FROM typeface_format_weight_stats
WHERE typeface_name = 'Trigger insert test';

ROLLBACK;
