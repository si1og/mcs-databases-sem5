CREATE TABLE typeface_format_weight_stats (
    id_font_family INT NOT NULL,
    typeface_name VARCHAR(100) NOT NULL,
    format_count BIGINT NOT NULL,
    weight_count BIGINT NOT NULL,

    PRIMARY KEY (id_font_family, typeface_name)
);

INSERT INTO typeface_format_weight_stats
SELECT
    t.id_font_family,
    t.name,
    COUNT(DISTINCT f.id_format),
    COUNT(DISTINCT w.id_weight)
FROM typeface AS t
JOIN format AS f ON f.id_format = t.id_format
JOIN weight AS w ON w.id_weight = t.id_weight
GROUP BY
    t.id_font_family,
    t.name;
