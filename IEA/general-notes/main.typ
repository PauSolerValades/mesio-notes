#import "math-template/template.typ": *
#import datetime

// Take a look at the file `template.typ` in the file panel

#let my_abstract = [
  Aquests apunts son un intent d'organitzar les meves idees i de omplir tots els buits que tinc en aquest bonic camp que és l'estadística
]

#show: project.with(
  title: "Inferència Estadística Avançada",
  authors: (
    (name: "Pau Soler Valadés", email: "pau.soler.valades@gmail.com"),
  ),
  abstract:my_abstract,
  date: datetime.today().display("[month repr:long] [year]"),
)
#{manage.is_main_document.update(true)}

#pagebreak()
#tableofcontents
#pagebreak()


= Tema 0: Bàsics i Prèvis
#include "tema0.typ"


#pagebreak()

= Tema 1: Reducció de Dades
#include "tema1.typ"

#pagebreak()
#bibliography(("citations.yml","citations.bib"),style:"ieee")