#import "../../../../../../poly-report/poly-report.typ": *

== Лабораторная работа № 4
=== Задача
Выбрать уровень изоляции и аномалию параллельного выполнения транзакций.
Сформировать сценарий из двух транзакций A и B, подтверждающий наличие
или отсутствие аномалии в PostgreSQL, выполнить его в двух сеансах
#raw(lang:"text", "psql") и обосновать результат.

=== Сценарий эксперимента
Выбраны уровень #raw(lang:"sql", "READ UNCOMMITTED") и фантомное чтение.
В PostgreSQL данный уровень работает как
#raw(lang:"sql", "READ COMMITTED"), а фантом проявляется, если повторный
запрос с тем же условием видит новую зафиксированную строку.

Транзакция A подсчитывает строки таблицы
#raw(lang:"text", "Font_family"), название которых начинается с
#raw(lang:"text", "Phantom read test"). Транзакция B добавляет
подходящую строку и фиксирует изменение, после чего A повторяет запрос.
Команды приведены в листингах~#ref(<lst:pr-04-transaction-a>, supplement: none)
и~#ref(<lst:pr-04-transaction-b>, supplement: none).

#code-listing(read("../../../practice-04/src/session-a.sql"), [Сценарий транзакции A], lang: "sql") <lst:pr-04-transaction-a>

#pagebreak()

#code-listing(read("../../../practice-04/src/session-b.sql"), [Сценарий транзакции B], lang: "sql") <lst:pr-04-transaction-b>

Хронология выполнения команд представлена в
таблице~#ref(<table:pr-04-transactions>, supplement: none)\; прочерк обозначает отсутствие
действия в соответствующем сеансе.

#a3-page(landscape: false)[
  #set text(size: 11pt)
  #figure(
    table(
      columns: (14mm, 1fr, 1fr),
      stroke: 0.5pt,
      inset: (x: 3pt, y: 3.4pt),
      align: (center, center, center),
      table.header([*№*], [*Действия транзакции A*], [*Действия транзакции B*]),
      [1], [#image("../../img/pr-04-transaction-a-01-begin.png", width: 94%)], [—],
      [2], [#image("../../img/pr-04-transaction-a-02-initial-read.png", width: 94%)], [—],
      [3], [—], [#image("../../img/pr-04-transaction-b-01-begin.png", width: 94%)],
      [4], [—], [#image("../../img/pr-04-transaction-b-02-insert.png", width: 94%)],
      [5], [#image("../../img/pr-04-transaction-a-03-uncommitted-read.png", width: 94%)], [—],
      [6], [—], [#image("../../img/pr-04-transaction-b-03-commit.png", width: 94%)],
      [7], [#image("../../img/pr-04-transaction-a-04-committed-read.png", width: 94%)], [—],
      [8], [#image("../../img/pr-04-transaction-a-05-commit.png", width: 94%)], [—],
    ),
    caption: [Выполнение сценария фантомного чтения на уровне `READ UNCOMMITTED`],
    kind: table,
  ) <table:pr-04-transactions>
]

=== Результат
На уровне изоляции #raw(lang:"sql", "READ UNCOMMITTED") возникает
фантомное чтение: в транзакции A сначала читается 0 подходящих строк,
транзакция B добавляет новую строку, до её фиксации число подходящих
строк остаётся равным 0, а после #raw(lang:"sql", "COMMIT") в транзакции
B повторный запрос в A возвращает 1, то есть в выборке появляется новое
фантомное значение.
