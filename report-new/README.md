# Отчёт по практике в Typst

Исходник: [`report.typ`](report.typ). Структура повторяет LaTeX-отчёт:
`tex/pages/` содержит титульный лист, содержание, введение, постановку задачи
и заключение; `sections/implementation/` — основную часть и разделы
лабораторных работ. Иллюстрации хранятся в `img/`, будущие диаграммы Typst —
в `typ/graphics/`. Листинги читаются из каталогов `practice-01`—`practice-04`.

Из старого LaTeX-отчёта напрямую подключается диаграмма
`../report/tex/graphics/db-schema-triggers.pdf`. Для практики № 5 отдельно
подготовлена и подключена TikZ-схема `../report/tex/graphics/db-schema-author.tex/pdf`.
Черновик `typ/graphics/db-schema-triggers.typ` пока не подключён к отчёту.
Общие стили импортируются из локального пакета Typst `@local/poly-report:0.1.0`.

Один раз зарегистрируйте локальный пакет и установите CM-Super в пользовательский
каталог. Для конвертации нужны TeX Live с CM-Super и FontForge.

```sh
make -C /Users/ilyasemenov/poly/poly-report install-package install-fonts
```

Сборка из корня `practice-sem5` (Typst 0.15.1):

```sh
typst compile --root . report-new/report.typ report-new/report.pdf
```

Для пересборки при изменениях используйте `typst watch` с теми же аргументами.
Корень проекта включает каталоги практик, откуда отчёт читает SQL и схемы.
Основной текст, заголовки и код используют те же контуры
CM-Super, что и исходный LaTeX-отчёт; цветовая тема SQL-листингов находится в
`poly-report/themes/lovelace.tmTheme`.

Исходный LaTeX-отчёт остаётся в `../report/`. Раздел лабораторной № 5 пока
содержит постановку задачи и схему; реализация будет добавлена позднее.
