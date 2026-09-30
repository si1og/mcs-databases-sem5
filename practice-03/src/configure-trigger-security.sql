ALTER FUNCTION font_family_updated_fn() SECURITY DEFINER;
ALTER FUNCTION font_family_updated_fn() SET search_path = public, pg_temp;

ALTER FUNCTION font_family_deleted_fn() SECURITY DEFINER;
ALTER FUNCTION font_family_deleted_fn() SET search_path = public, pg_temp;

ALTER FUNCTION typeface_inserted_fn() SECURITY DEFINER;
ALTER FUNCTION typeface_inserted_fn() SET search_path = public, pg_temp;

ALTER FUNCTION typeface_updated_fn() SECURITY DEFINER;
ALTER FUNCTION typeface_updated_fn() SET search_path = public, pg_temp;

ALTER FUNCTION typeface_deleted_fn() SECURITY DEFINER;
ALTER FUNCTION typeface_deleted_fn() SET search_path = public, pg_temp;

REVOKE ALL ON FUNCTION font_family_updated_fn() FROM PUBLIC;
REVOKE ALL ON FUNCTION font_family_deleted_fn() FROM PUBLIC;
REVOKE ALL ON FUNCTION typeface_inserted_fn() FROM PUBLIC;
REVOKE ALL ON FUNCTION typeface_updated_fn() FROM PUBLIC;
REVOKE ALL ON FUNCTION typeface_deleted_fn() FROM PUBLIC;
