SELECT
    c.id_category,
    c.name,
    SUM(v.format_count) AS format_count
FROM typeface_format_weight_stats AS v
JOIN font_family AS ff
    ON ff.id_font_family = v.id_font_family
JOIN category AS c
    ON c.id_category = ff.id_category
GROUP BY c.id_category, c.name
ORDER BY format_count DESC, c.name
LIMIT 5;
