#import "../../../../poly-report/poly-report.typ": *

#show: report.with(
  font: "CM Super 1440",
  code-font: "CM Super Typewriter 1200",
  large-heading-font: "CM Super 1728",
)

#set page(numbering: none)
#include "tex/pages/title.typ"
#include "tex/pages/toc.typ"
#include "tex/pages/introduction.typ"
#include "tex/pages/task.typ"
#include "sections/implementation/implementation.typ"
#include "tex/pages/conclusion.typ"
