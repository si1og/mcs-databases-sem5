CREATE OR REPLACE FUNCTION typeface_updated_fn()
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
    WHERE (t.id_font_family = OLD.id_font_family AND t.name = OLD.name)
       OR (t.id_font_family = NEW.id_font_family AND t.name = NEW.name)
    GROUP BY
        t.id_font_family,
        t.name
    ON CONFLICT (id_font_family, typeface_name)
    DO UPDATE SET
        format_count = EXCLUDED.format_count,
        weight_count = EXCLUDED.weight_count;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS typeface_updated ON typeface;

CREATE TRIGGER typeface_updated
AFTER UPDATE OF id_font_family, name, id_format, id_weight ON typeface
FOR EACH ROW
EXECUTE FUNCTION typeface_updated_fn();
