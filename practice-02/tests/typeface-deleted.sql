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
    'Trigger delete test',
    id_weight,
    id_slope,
    file_size,
    id_font_family,
    id_format
FROM typeface
ORDER BY id_typeface
LIMIT 1;

DELETE FROM typeface
WHERE name = 'Trigger delete test';

-- должен вернуть 0, т.к. удалили

SELECT COUNT(*)
FROM typeface_format_weight_stats
WHERE typeface_name = 'Trigger delete test';

ROLLBACK;
