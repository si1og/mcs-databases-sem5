-- удаляем всё дальше по цепочке
CREATE OR REPLACE FUNCTION font_family_deleted_fn()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM typeface
    WHERE id_font_family = OLD.id_font_family;

    DELETE FROM typeface_format_weight_stats
    WHERE id_font_family = OLD.id_font_family;

    RETURN OLD;
END;
$$;

DROP TRIGGER IF EXISTS font_family_deleted ON font_family;

CREATE TRIGGER font_family_deleted
BEFORE DELETE ON font_family
FOR EACH ROW
EXECUTE FUNCTION font_family_deleted_fn();
