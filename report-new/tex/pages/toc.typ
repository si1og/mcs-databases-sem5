#set page(numbering: "1")
#counter(page).update(1)
#heading(level: 1, numbering: none, outlined: false)[Содержание]
#v(9mm)
#set outline.entry(fill: repeat([.], gap: 0.4em))
#show outline.entry: set block(above: 8pt)
#show outline.entry.where(level: 1): set outline.entry(fill: none)
#show outline.entry.where(level: 1): set block(above: 15pt)
#show outline.entry.where(level: 1): set text(weight: "semibold")
#show outline.entry: it => {
  if it.body() == [Введение] {
    set par(first-line-indent: 0pt)
    link(it.element.location(), [#text(fill: blue, it.body())#h(1fr)#it.page()])
  } else {
    link(
      it.element.location(),
      it.indented(
        text(fill: blue, it.prefix()),
        [#text(fill: blue, it.body())#h(4pt)#box(width: 1fr, it.fill)#h(4pt)#it.page()],
        gap: 1em,
      ),
    )
  }
}
#outline(title: none, depth: 3, indent: n => if n == 0 { 0mm } else if n == 1 { 7mm } else { 18mm })
#pagebreak()
