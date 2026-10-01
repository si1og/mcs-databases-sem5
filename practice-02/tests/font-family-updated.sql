BEGIN;

SELECT id_font_family, name FROM font_family LIMIT 10;

UPDATE font_family
SET id_font_family = 10000
WHERE id_font_family = 1;

SELECT f.id_font_family, f.name, t.name FROM font_family AS f
JOIN typeface t ON t.id_font_family = f.id_font_family WHERE t.id_font_family = 10000;

SELECT *
FROM typeface_format_weight_stats
WHERE id_font_family = 10000
ORDER BY typeface_name;

ROLLBACK;
