#import "@preview/fletcher:0.6.0": diagram, node, edge

#let add-typeface-flowchart = {
  set text(size: 11pt, hyphenate: false)
  set par(justify: false, first-line-indent: 0pt)

  let step = node.with(width: 62mm, height: 11mm, inset: 3pt)
  let decision = node.with(shape: "diamond", width: 38mm, inset: 3pt)
  let terminal = node.with(shape: "ellipse", width: 26mm, height: 9mm)
  let junction = node.with(shape: "ellipse", inset: 0pt, width: 1mm, height: 1mm, fill: black)
  let arrow(..vertices) = edge(..vertices, "-|>")
  let branch(from, to, label) = edge(from, to, "-|>", label)

  let parameters = block(
    stroke: (left: 0.6pt),
    inset: (left: 5pt),
    [
      Фамилия автора: строка \
      Имя автора: строка \
      Отчество автора: строка \
      Организация автора: строка \
      Электронная почта автора: строка \
      Название категории: строка \
      Название гарнитуры: строка \
      Название начертания: строка \
      Название формата начертания: строка \
      Насыщенность начертания: строка \
      Наклон начертания: строка \
      Размер файла начертания: целое число
    ],
  )

  diagram(
    spacing: (7mm, 7mm),
    node-stroke: 0.6pt,
    edge-stroke: 0.6pt,

    terminal((1, 0), [Начало]),
    step((1, 7), [Найти формат, насыщенность и наклон]),
    decision((1, 8), [Все три значения\ найдены?]),
    step((2, 8), [Сообщить об ошибке и отменить изменения]),
    step((1, 9), [Найти автора по почте]),
    decision((1, 10), [Автор\ найден?]),
    step((2, 10), [Создать автора]),
    step((1, 12), [Найти категорию по названию]),
    decision((1, 13), [Категория\ найдена?]),
    step((2, 13), [Создать категорию со счётчиком 0]),
    step((1, 15), [Найти гарнитуру по названию, автору и категории]),
    decision((1, 16), [Гарнитура\ найдена?]),
    step((2, 16), [Создать гарнитуру и увеличить счётчик категории]),
    step((1, 18), [Найти начертание по названию, формату, насыщенности и наклону]),
    decision((1, 19), [Начертание\ найдено?]),
    step((2, 19), [Добавить начертание и увеличить счётчик гарнитуры]),
    decision((1, 20), [Размер файла\ совпадает?]),
    step((0, 20), [Обновить размер файла]),
    terminal((1, 22), [Конец]),
    junction((1, 11)),
    junction((1, 14)),
    junction((1, 17)),
    junction((1, 21)),

    arrow((1, 0), (1, 7)),
    edge(
      (1, 3.5), (1.8, 3.5),
      stroke: (paint: black, thickness: 0.6pt, dash: "dotted"),
      label: (body: parameters, pos: 100%, side: end, sep: 0pt),
    ),
    arrow((1, 7), (1, 8)),
    branch((1, 8), (1, 9), [Да]),
    branch((1, 8), (2, 8), [Нет]),
    edge((2, 8), (3, 8), (3, 21), (2, 21)),

    arrow((1, 9), (1, 10)),
    edge((1, 10), (1, 11), [Да]),
    branch((1, 10), (2, 10), [Нет]),
    edge((2, 10), (2, 11), (1, 11)),
    arrow((1, 11), (1, 12)),

    arrow((1, 12), (1, 13)),
    edge((1, 13), (1, 14), [Да]),
    branch((1, 13), (2, 13), [Нет]),
    edge((2, 13), (2, 14), (1, 14)),
    arrow((1, 14), (1, 15)),

    arrow((1, 15), (1, 16)),
    edge((1, 16), (1, 17), [Да]),
    branch((1, 16), (2, 16), [Нет]),
    edge((2, 16), (2, 17), (1, 17)),
    arrow((1, 17), (1, 18)),

    arrow((1, 18), (1, 19)),
    branch((1, 19), (2, 19), [Нет]),
    branch((1, 19), (1, 20), [Да]),
    branch((1, 20), (0, 20), [Нет]),
    edge((1, 20), (1, 21), [Да]),
    edge((2, 19), (2, 21), (1, 21)),
    edge((0, 20), (0, 21), (1, 21)),
    arrow((1, 21), (1, 22)),
  )
}
