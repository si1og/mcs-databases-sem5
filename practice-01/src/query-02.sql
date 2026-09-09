SELECT
	COUNT(v.id_font_family)
FROM typeface_format_weight_stats AS v
WHERE v.format_count > 2;
