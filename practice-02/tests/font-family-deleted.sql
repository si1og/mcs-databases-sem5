BEGIN;

INSERT INTO font_family (
    id_font_family,
    name,
    typeface_count,
    id_category
)
SELECT
    10000, -- задаём занчения явно
    'Trigger delete test family',
    0,
    id_category
FROM font_family
ORDER BY id_font_family
LIMIT 1;

INSERT INTO typeface (
    name,
    id_weight,
    id_slope,
    file_size,
    id_font_family,
    id_format
)
SELECT
    'Family delete test typeface',
    id_weight,
    id_slope,
    file_size,
    10000,
    id_format
FROM typeface
ORDER BY id_typeface
LIMIT 1;

-- показываем, что добавился
SELECT *
FROM typeface_format_weight_stats
WHERE id_font_family = 10000;

DELETE FROM font_family
WHERE id_font_family = 10000;

SELECT COUNT(*)
FROM typeface_format_weight_stats
WHERE id_font_family = 10000;

ROLLBACK;
