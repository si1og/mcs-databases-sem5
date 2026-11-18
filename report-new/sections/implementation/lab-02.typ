#import "@local/poly-report:0.1.0": *

== Лабораторная работа № 2
=== Задача
Необходимо реализовать таблицу
#raw(lang:"text", "Typeface_format_weight_stats"), содержимое которой
повторяет результат представления, созданного в первой лабораторной
работе. Таблица должна хранить для каждого начертания идентификатор
гарнитуры, название начертания, число поддерживаемых форматов и
количество градаций насыщенности.

Актуальность агрегированных данных необходимо обеспечить с помощью
триггеров на таблицах #raw(lang:"text", "Font_family") и
#raw(lang:"text", "Typeface"). При изменении исходных данных
соответствующие строки таблицы статистики должны обновляться
автоматически.

Требуется реализовать пять триггеров, покрывающих следующие изменения:

+ изменение идентификатора гарнитуры в таблице
  #raw(lang:"text", "Font_family")\;

+ удаление гарнитуры из таблицы #raw(lang:"text", "Font_family")\;

+ добавление начертания в таблицу #raw(lang:"text", "Typeface")\;

+ изменение гарнитуры, названия, формата или насыщенности начертания в
  таблице #raw(lang:"text", "Typeface")\;

+ удаление начертания из таблицы #raw(lang:"text", "Typeface").

Обновлённая схема базы данных представлена на
рисунке~#ref(<fig:db-schema-triggers>, supplement: none).

=== Реализация триггеров
В PostgreSQL обработчик триггера оформляется в виде функции,
возвращающей значение типа #text(fill: rgb("#2938B0"), raw("TRIGGER", lang: "sql")). После объявления
функции команда #raw(lang:"sql", "CREATE TRIGGER") связывает её с
таблицей, событием и моментом выполнения.

#strong[Триггер #raw(lang:"text", "font_family_updated").] Триггер
выполняется перед изменением идентификатора гарнитуры. Он переносит на
новый идентификатор строки таблицы статистики и связанные начертания.
Внешний ключ #raw(lang:"sql", "typeface.id_font_family") объявляется
отложенным, поэтому его проверка производится после завершения изменения
гарнитуры. Реализация триггера приведена в
листинге~#ref(<lst:font-family-updated-trigger>, supplement: none).

#code-listing(read("../../../practice-02/src/triggers/font-family-updated.sql"), [Триггер изменения гарнитуры], lang: "sql") <lst:font-family-updated-trigger>

#strong[Триггер #raw(lang:"text", "font_family_deleted").] Триггер
выполняется перед удалением гарнитуры. Сначала он удаляет принадлежащие
ей начертания, после чего удаляет соответствующие агрегированные строки.
Это позволяет выполнить операцию без каскадного удаления на уровне
внешнего ключа. Реализация приведена в
листинге~#ref(<lst:font-family-deleted-trigger>, supplement: none).

#code-listing(read("../../../practice-02/src/triggers/font-family-deleted.sql"), [Триггер удаления гарнитуры], lang: "sql") <lst:font-family-deleted-trigger>

#strong[Триггер #raw(lang:"text", "typeface_inserted").] После
добавления начертания триггер подсчитывает число различных форматов и
градаций насыщенности для соответствующей пары из идентификатора
гарнитуры и названия начертания. Если агрегированная строка уже
существует, её значения обновляются конструкцией
#raw(lang:"sql", "ON CONFLICT"). Реализация приведена в
листинге~#ref(<lst:typeface-inserted-trigger>, supplement: none).

#code-listing(read("../../../practice-02/src/triggers/typeface-inserted.sql"), [Триггер добавления начертания], lang: "sql") <lst:typeface-inserted-trigger>

#strong[Триггер #raw(lang:"text", "typeface_updated").] Триггер
запускается после изменения гарнитуры, названия, формата или
насыщенности начертания. Старая агрегированная строка удаляется, затем
по актуальным данным заново рассчитываются показатели старой и новой
групп. Реализация приведена в листинге~#ref(<lst:typeface-updated-trigger>, supplement: none).

#code-listing(read("../../../practice-02/src/triggers/typeface-updated.sql"), [Триггер изменения начертания], lang: "sql") <lst:typeface-updated-trigger>

#strong[Триггер #raw(lang:"text", "typeface_deleted").] После удаления
начертания триггер удаляет прежнюю агрегированную строку и повторно
рассчитывает её по оставшимся начертаниям. Если записей с такой парой
гарнитуры и названия больше нет, новая строка не создаётся. Реализация
приведена в листинге~#ref(<lst:typeface-deleted-trigger>, supplement: none).

#code-listing(read("../../../practice-02/src/triggers/typeface-deleted.sql"), [Триггер удаления начертания], lang: "sql") <lst:typeface-deleted-trigger>

=== Проверка работы триггеров
Для каждого триггера подготовлен отдельный тестовый запрос. Все проверки
выполняются внутри транзакции, которая завершается командой
#raw(lang:"sql", "ROLLBACK")\; поэтому тестовые изменения не сохраняются
в базе данных. Рассмотренные сценарии приведены в
таблице~#ref(<table:trigger-tests>, supplement: none).

#figure(
  table(
    columns: (12mm, 1fr),
    stroke: 0.5pt,
    inset: 4pt,
    align: (center, left),
    table.header([*№*], [*Действие*]),
    [1], [Изменение идентификатора гарнитуры (`UPDATE id_font_family` в `Font_family`). Идентификатор изменяется в связанных начертаниях и строках `Typeface_format_weight_stats`.],
    [2], [Удаление гарнитуры (`DELETE` из `Font_family`). Связанные начертания и агрегированные строки удаляются триггером.],
    [3], [Добавление начертания (`INSERT` в `Typeface`). В таблице статистики создаётся новая строка либо пересчитываются существующие счётчики.],
    [4], [Изменение начертания (`UPDATE` полей `id_font_family`, `name`, `id_format` или `id_weight`). Показатели старой и новой групп пересчитываются.],
    [5], [Удаление начертания (`DELETE` из `Typeface`). Счётчики группы пересчитываются, а при отсутствии других начертаний агрегированная строка удаляется.],
  ),
  caption: [Примеры работы триггеров],
  kind: table,
) <table:trigger-tests>

Результаты выполнения тестовых запросов представлены на
рисунках~#ref(<fig:font-family-updated-result>, supplement: none) – #ref(<fig:typeface-deleted-result>, supplement: none).

#image-figure(image("../../img/pr-02-font-family-updated-result.png", width: 90%), [Результат изменения идентификатора гарнитуры]) <fig:font-family-updated-result>

#image-figure(image("../../img/pr-02-font-family-deleted-result.png", width: 35%), [Результат удаления гарнитуры]) <fig:font-family-deleted-result>

#image-figure(image("../../img/pr-02-typeface-inserted-result.png", width: 90%), [Результат добавления начертания]) <fig:typeface-inserted-result>

#image-figure(image("../../img/pr-02-typeface-updated-result.png", width: 90%), [Результат изменения начертания]) <fig:typeface-updated-result>

#image-figure(image("../../img/pr-02-typeface-deleted-result.png", width: 30%), [Результат удаления начертания]) <fig:typeface-deleted-result>

=== Схема базы данных
В исходную схему добавлена таблица
#raw(lang:"text", "Typeface_format_weight_stats"). Пунктирные стрелки
показывают операции, при выполнении которых триггеры изменяют
содержащиеся в ней агрегированные значения. Обновлённая схема
представлена на рисунке~#ref(<fig:db-schema-triggers>, supplement: none).

#a3-page[
  #figure(
    image("../../../report/tex/graphics/db-schema-triggers.pdf", width: 100%, height: 235mm, fit: "contain"),
    caption: [Схема базы данных с таблицей статистики и триггерами],
    kind: image,
  ) <fig:db-schema-triggers>
]
