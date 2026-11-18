#import "../../../../../../poly-report/poly-report.typ": *

== Лабораторная работа № 3
=== Задача
Создать двух пользователей базы данных, обладающих различными правами
доступа. Первый пользователь должен быть предназначен для просмотра
статистики по начертаниям. Второй пользователь должен иметь возможность
работать с агрегированными и исходными данными, связанными с этой
статистикой.

+ Пользователь #raw(lang:"text", "stats_reader") может только
  просматривать таблицу
  #raw(lang:"text", "typeface_format_weight_stats"). Ему доступна
  операция #raw(lang:"sql", "SELECT") из этой таблицы, ко всем остальным
  таблицам доступа нет.

+ Пользователь #raw(lang:"text", "source_editor") имеет полный доступ к
  таблицам #raw(lang:"text", "Font_family") и
  #raw(lang:"text", "Typeface"), изменения которых влияют на таблицу
  статистики. Ему также разрешено чтение и изменение
  #raw(lang:"text", "typeface_format_weight_stats"). Доступ к остальным
  таблицам базы данных запрещён.

Для проверки назначенных прав требуется выполнить один набор тестовых
запросов от имени обоих пользователей и сопоставить полученные
результаты.

=== Создание пользователей и назначение прав
Командами #raw(lang:"sql", "CREATE USER") создаются пользователи
#raw(lang:"text", "stats_reader") и #raw(lang:"text", "source_editor").
Обоим пользователям разрешаются подключение к базе данных, использование
схемы #raw(lang:"text", "public") и чтение таблицы статистики.
Пользователь #raw(lang:"text", "source_editor") дополнительно получает
права на изменение связанных таблиц и используемые ими
последовательности. Полный скрипт приведён в листинге~#ref(<lst:pr-03-users>, supplement: none).

#code-listing(read("../../../practice-03/src/users.sql"), [Создание пользователей и назначение прав], lang: "sql") <lst:pr-03-users>

=== Тестовые примеры
Для проверки прав подготовлено десять запросов. Каждый запрос
выполняется без изменений сначала от имени
#raw(lang:"text", "stats_reader"), затем от имени
#raw(lang:"text", "source_editor").

Первый запрос проверяет чтение таблицы статистики. Эта операция должна
быть доступна обоим пользователям. Текст запроса приведён в
листинге~#ref(<lst:pr-03-query-01>, supplement: none).

#code-listing(read("../../../practice-03/tests/queries/01-select-stats.sql"), [Чтение таблицы статистики], lang: "sql") <lst:pr-03-query-01>

Второй запрос проверяет возможность непосредственного добавления строки
таблицы статистики. Третий запрос читает её по составному первичному
ключу, а четвёртый удаляет. Тексты запросов приведены в
листингах~#ref(<lst:pr-03-query-02>, supplement: none) – #ref(<lst:pr-03-query-04>, supplement: none).

#code-listing(read("../../../practice-03/tests/queries/02-insert-stats.sql"), [Добавление строки таблицы статистики], lang: "sql") <lst:pr-03-query-02>

#code-listing(read("../../../practice-03/tests/queries/03-select-inserted-stats.sql"), [Проверка добавленной строки таблицы статистики], lang: "sql") <lst:pr-03-query-03>

#code-listing(read("../../../practice-03/tests/queries/04-delete-stats.sql"), [Удаление строки таблицы статистики], lang: "sql") <lst:pr-03-query-04>

Пятый запрос добавляет тестовое начертание, копируя значения внешних
ключей из первой существующей строки. Текст запроса приведён в
листинге~#ref(<lst:pr-03-query-05>, supplement: none).

#code-listing(read("../../../practice-03/tests/queries/05-insert-typeface.sql"), [Добавление тестового начертания], lang: "sql") <lst:pr-03-query-05>

Шестой запрос проверяет наличие добавленного начертания в исходной
таблице #raw(lang:"text", "Typeface"). Седьмой запрос изменяет его
название, а восьмой выбирает изменённую строку по идентификатору. Тексты
запросов приведены в листингах~#ref(<lst:pr-03-query-06>, supplement: none) – #ref(<lst:pr-03-query-08>, supplement: none).

#code-listing(read("../../../practice-03/tests/queries/06-select-typeface.sql"), [Проверка добавленного начертания], lang: "sql") <lst:pr-03-query-06>

#code-listing(read("../../../practice-03/tests/queries/07-update-typeface.sql"), [Изменение тестового начертания], lang: "sql") <lst:pr-03-query-07>

#code-listing(read("../../../practice-03/tests/queries/08-select-updated-typeface.sql"), [Проверка изменённого начертания], lang: "sql") <lst:pr-03-query-08>

Девятый запрос удаляет добавленное ранее тестовое начертание. Десятый
запрос обращается к таблице #raw(lang:"text", "Category"), права на
которую не были назначены ни одному из пользователей. Тексты запросов
приведены в листингах~#ref(<lst:pr-03-query-09>, supplement: none) и~#ref(<lst:pr-03-query-10>, supplement: none).

#code-listing(read("../../../practice-03/tests/queries/09-delete-typeface.sql"), [Удаление тестового начертания], lang: "sql") <lst:pr-03-query-09>

#code-listing(read("../../../practice-03/tests/queries/10-select-category.sql"), [Чтение таблицы без назначенных прав], lang: "sql") <lst:pr-03-query-10>

=== Результаты тестирования
Результаты выполнения одного набора запросов от имени двух пользователей
сопоставлены в таблице~#ref(<table:pr-03-access-tests>, supplement: none). В первой строке
каждого примера приведён текст запроса, во второй --- результаты его
выполнения.

#a3-page(landscape: false)[
  #set text(size: 10pt)
  #figure(
    table(
      columns: (14mm, 1fr, 1fr),
      stroke: 0.5pt,
      inset: (x: 3pt, y: 6.7pt),
      align: (center, left, left),
      table.header([*№*], [*stats_reader*], [*source_editor*]),
      table.cell(rowspan: 2)[1],
      table.cell(colspan: 2)[#raw("SELECT * FROM typeface_format_weight_stats LIMIT 3;")],
      table.cell(colspan: 2, align: center)[#image("../../img/pr-03-query-01-result.png", width: 85%)],
      table.cell(rowspan: 2)[2],
      table.cell(colspan: 2)[#raw("INSERT INTO typeface_format_weight_stats (...) VALUES (-1, 'Permission test', 1, 1);")],
      table.cell(colspan: 2, align: center)[#image("../../img/pr-03-query-02-result.png", width: 85%)],
      table.cell(rowspan: 2)[3],
      table.cell(colspan: 2)[#raw("SELECT * FROM typeface_format_weight_stats WHERE id_font_family = -1 AND typeface_name = 'Permission test';")],
      table.cell(colspan: 2, align: center)[#image("../../img/pr-03-query-03-result.png", width: 85%)],
      table.cell(rowspan: 2)[4],
      table.cell(colspan: 2)[#raw("DELETE FROM typeface_format_weight_stats WHERE id_font_family = -1;")],
      table.cell(colspan: 2, align: center)[#image("../../img/pr-03-query-04-result.png", width: 85%)],
      table.cell(rowspan: 2)[5],
      table.cell(colspan: 2)[#raw("INSERT INTO typeface (...) SELECT ... FROM typeface ORDER BY id_typeface LIMIT 1;")],
      table.cell(colspan: 2, align: center)[#image("../../img/pr-03-query-05-result.png", width: 85%)],
      table.cell(rowspan: 2)[6],
      table.cell(colspan: 2)[#raw("SELECT id_typeface, name FROM typeface WHERE name = 'Permission test';")],
      table.cell(colspan: 2, align: center)[#image("../../img/pr-03-query-06-result.png", width: 85%)],
      table.cell(rowspan: 2)[7],
      table.cell(colspan: 2)[#raw("UPDATE typeface SET name = 'Permission test updated' WHERE id_typeface = 1000000;")],
      table.cell(colspan: 2, align: center)[#image("../../img/pr-03-query-07-result.png", width: 85%)],
      table.cell(rowspan: 2)[8],
      table.cell(colspan: 2)[#raw("SELECT id_typeface, name FROM typeface WHERE id_typeface = 1000000;")],
      table.cell(colspan: 2, align: center)[#image("../../img/pr-03-query-08-result.png", width: 85%)],
      table.cell(rowspan: 2)[9],
      table.cell(colspan: 2)[#raw("DELETE FROM typeface WHERE id_typeface = 1000000;")],
      table.cell(colspan: 2, align: center)[#image("../../img/pr-03-query-09-result.png", width: 85%)],
      table.cell(rowspan: 2)[10],
      table.cell(colspan: 2)[#raw("SELECT * FROM category LIMIT 3;")],
      table.cell(colspan: 2, align: center)[#image("../../img/pr-03-query-10-result.png", width: 85%)],
    ),
    caption: [Результаты тестовых запросов],
    kind: table,
  ) <table:pr-03-access-tests>
]
