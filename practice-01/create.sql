CREATE OR REPLACE VIEW typeface_format_weight_stats AS
SELECT
    t.id_font_family,
    t.name AS typeface_name,
    COUNT(DISTINCT t.id_format) AS format_count,
    COUNT(DISTINCT t.id_weight) AS weight_count
FROM typeface AS t
GROUP BY
    t.id_font_family,
    t.name;
