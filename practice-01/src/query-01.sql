SELECT
	v.id_font_family,
	v.typeface_name,
	v.format_count,
	v.weight_count
FROM typeface_format_weight_stats AS v
ORDER BY v.id_font_family, v.typeface_name;
