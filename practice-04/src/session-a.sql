BEGIN;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- до вставки в сеансе B ожидается 0 строк
SELECT COUNT(*) AS matching_families
FROM font_family
WHERE name LIKE 'Phantom read test%';

-- выполняем INSERT в сеансе B

-- проверка на грязное чтение, должно быть 0 строк (т.к. READ UNCOMMITTED эквивалентен READ COMMITTED)
SELECT COUNT(*) AS matching_families
FROM font_family
WHERE name LIKE 'Phantom read test%';

-- выполняем COMMIT в сеансе B

-- после COMMIT возникает фантом: ожидается 1 строка
SELECT COUNT(*) AS matching_families
FROM font_family
WHERE name LIKE 'Phantom read test%';

COMMIT;
