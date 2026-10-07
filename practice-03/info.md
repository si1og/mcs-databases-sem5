# Подключение к базе данных

## Пользователь для чтения статистики

```bash
docker exec -e PGPASSWORD=stats_reader -it typography_coursework_db \
  psql -h localhost -U stats_reader -d typography
```

## Редактор исходных таблиц

```bash
docker exec -e PGPASSWORD=source_editor -it typography_coursework_db \
  psql -h localhost -U source_editor -d typography
```

## Администратор

```bash
docker exec -it typography_coursework_db \
  psql -U ilyasemenov -d typography
```

Текущего пользователя можно проверить запросом:

```sql
SELECT current_user;
```
