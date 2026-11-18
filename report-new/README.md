# Отчёт по практике в Typst

Исходник: [`report.typ`](report.typ). Структура повторяет LaTeX-отчёт:
`tex/pages/` содержит титульный лист, содержание, введение, постановку задачи
и заключение; `sections/implementation/` — основную часть и разделы
лабораторных работ. Иллюстрации хранятся в `img/`, будущие диаграммы Typst —
в `typ/graphics/`. Листинги читаются из каталогов `practice-01`—`practice-04`.

Из старого LaTeX-отчёта напрямую подключается только диаграмма
`../report/tex/graphics/db-schema-triggers.pdf`. Для практики № 5 отдельно
подготовлена TikZ-схема `../report/tex/graphics/db-schema-author.tex/pdf`.
Черновик `typ/graphics/db-schema-triggers.typ` пока не подключён к отчёту.
Общие стили импортируются из соседнего репозитория `poly-report`.

Сборка из корня `practice-sem5` (Typst 0.15.1):

```sh
make -C /Users/ilyasemenov/poly/poly-report cm-super-fonts
typst compile --root /Users/ilyasemenov/poly \
  --font-path /Users/ilyasemenov/poly/poly-report/fonts/cm-super \
  report-new/report.typ report-new/report.pdf
```

Для другой копии проекта укажите в `--root` общий родительский каталог,
содержащий `poly-report` и `5sem/databases/practice-sem5`, а в `--font-path` —
каталог `poly-report/fonts/cm-super`. Для подготовки шрифтов нужны TeX Live
с CM-Super и FontForge. Основной текст, заголовки и код используют те же контуры
CM-Super, что и исходный LaTeX-отчёт; цветовая тема SQL-листингов находится в
`poly-report/themes/lovelace.tmTheme`.

Исходный LaTeX-отчёт остаётся в `../report/`. Typst-версия содержит те же
28 страниц, включая три листа A3.
