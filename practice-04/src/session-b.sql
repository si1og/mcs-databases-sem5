BEGIN;

INSERT INTO font_family (
    name,
    typeface_count,
    id_category
)
SELECT
    'Phantom read test family',
    0,
    id_category
FROM font_family
ORDER BY id_font_family
LIMIT 1
RETURNING id_font_family, name;

-- выполняем второе чтение в сеансе A

COMMIT;
