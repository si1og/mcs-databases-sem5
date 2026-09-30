DROP OWNED BY stats_reader;
DROP OWNED BY source_editor;

DROP USER IF EXISTS stats_reader;
DROP USER IF EXISTS source_editor;

CREATE USER stats_reader PASSWORD 'stats_reader';
CREATE USER source_editor PASSWORD 'source_editor';

GRANT CONNECT ON DATABASE typography
TO stats_reader, source_editor;

GRANT USAGE ON SCHEMA public
TO stats_reader, source_editor;

GRANT SELECT ON typeface_format_weight_stats
TO stats_reader, source_editor;

GRANT SELECT, INSERT, UPDATE, DELETE ON font_family, typeface
TO source_editor;

GRANT USAGE, SELECT ON SEQUENCE
    font_family_id_font_family_seq,
    typeface_id_typeface_seq
TO source_editor;

GRANT INSERT, UPDATE, DELETE
ON TABLE font_family, typeface, typeface_format_weight_stats
TO source_editor;
