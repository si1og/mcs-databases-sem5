CREATE OR REPLACE FUNCTION typeface_deleted_fn()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM typeface_format_weight_stats
    WHERE id_font_family = OLD.id_font_family
      AND typeface_name = OLD.name;

    INSERT INTO typeface_format_weight_stats
    SELECT
        t.id_font_family,
        t.name,
        COUNT(DISTINCT f.id_format),
        COUNT(DISTINCT w.id_weight)
    FROM typeface AS t
    JOIN format AS f ON f.id_format = t.id_format
    JOIN weight AS w ON w.id_weight = t.id_weight
    WHERE t.id_font_family = OLD.id_font_family
      AND t.name = OLD.name
    GROUP BY
        t.id_font_family,
        t.name;

    RETURN OLD;
END;
$$;

CREATE TRIGGER typeface_deleted
AFTER DELETE ON typeface
FOR EACH ROW
EXECUTE FUNCTION typeface_deleted_fn();
