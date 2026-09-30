ALTER TABLE typeface
ALTER CONSTRAINT typeface_id_font_family_fkey
DEFERRABLE INITIALLY DEFERRED;

CREATE OR REPLACE FUNCTION font_family_updated_fn()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE typeface_format_weight_stats
    SET id_font_family = NEW.id_font_family
    WHERE id_font_family = OLD.id_font_family;

    UPDATE typeface
    SET id_font_family = NEW.id_font_family
    WHERE id_font_family = OLD.id_font_family;

    RETURN NEW;
END;
$$;

CREATE TRIGGER font_family_updated
BEFORE UPDATE OF id_font_family ON font_family
FOR EACH ROW
EXECUTE FUNCTION font_family_updated_fn();
