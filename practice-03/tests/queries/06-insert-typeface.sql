INSERT INTO typeface (
    id_typeface,
    name,
    id_weight,
    id_slope,
    file_size,
    id_font_family,
    id_format
)
SELECT
    1000000,
    'Permission test',
    id_weight,
    id_slope,
    file_size,
    id_font_family,
    id_format
FROM typeface
ORDER BY id_typeface
LIMIT 1;
