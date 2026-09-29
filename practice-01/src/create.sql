CREATE OR REPLACE VIEW typeface_format_weight_stats AS
SELECT
    t.id_font_family,
    t.name AS typeface_name,
    COUNT(DISTINCT f.id_format) AS format_count,
    COUNT(DISTINCT w.id_weight) AS weight_count
FROM typeface AS t
JOIN format AS f ON f.id_format = t.id_format
JOIN weight AS w ON w.id_weight = t.id_weight
GROUP BY
    t.id_font_family,
    t.name;
