SELECT
	COUNT(v.id_font_family)
FROM typeface_format_weight_stats_view AS v
WHERE v.format_count > 2;
