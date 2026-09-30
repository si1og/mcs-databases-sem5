BEGIN;

UPDATE font_family
SET id_font_family = 10000
WHERE id_font_family = 1;

SELECT *
FROM typeface_format_weight_stats
WHERE id_font_family = 10000
ORDER BY typeface_name;

ROLLBACK;
