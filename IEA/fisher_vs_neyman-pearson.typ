#let project(
  title: "",
  authors: "",
  date: "",
  body
) = {
  // Document properties
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "New Computer Modern")

  // Title block
  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #v(1em)
    #text(1.25em, authors)
    #v(0.5em)
    #text(1em, date)
    #v(2em)
  ]

  // Main content
  body
}

#show: project.with(
  title: "Tests d'hipòtesi - Diferències entre Fisher i Neyman-Pearson",
  authors: "Pau Soler Valadés",
  date: "November 2024",
)

Encara que Neyman-Pearson parli d'una hipòtesi alternativa, la intenció tant de Fisher com de Neyman-Pearson era la mateixa: comprovar si la hipòtesi nul·la (o principal) és correcta. La diferència fonamental entre els dos és que Neyman-Pearson t'obliga a explicitar la hipòtesi alternativa, mentre que Fisher només et permet rebutjar o no la hipòtesi nul·la segons els resultats dels tests. Aleshores, l'elecció de la hipòtesi alternativa queda lligada a un esdeveniment plausible dins de les modificacions de la hipòtesi nul·la, és a dir, no pots escollir qualsevol cosa com a hipòtesi alternativa, sinó només la modificació de la hipòtesi nul·la corresponent. La filosofia d'aquesta elecció es pot resumir amb "_significatiu vs no significatiu_" o "$H_A$ (el canvi és significatiu) vs $H_M$ (el canvi no és significatiu)", que en essència és el mateix que fa Fisher (significatiu és rebutjo $H_0$ i no significatiu és no rebutjo $H_0$), però sense explicitar la hipòtesi alternativa.

== Hipòtesi Plausible
#table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  stroke: 0.7pt,
  [*$H_0$ Fisher*], [*$H_P$ Neyman-Pearson*],
  [
    No s'explicita en general
  ],
  [
    Concebuda a priori, a l'etapa de disseny
  ],
  [
    No té res a veure amb la mida de l'efecte
  ],
  [
    Conté el MSE (_minimum size effect_) a la formulació
  ],
  [
    Es busca rebutjar amb proves
  ],
  [
    S'escull entre $H_P$ i entre $H_A$
  ],
)

== Regió Crítica
#table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  stroke: 0.7pt,
  [*Fisher*], [*Neyman-Pearson*],
  [
    Depen del nivell de significació determinat a posterior, i s'aprova amb el _p-value_
  ],
  [
    S'ha de trobar el valor crític $alpha$ per poder delimitar la regió crítica.
  ],
  [
    Nivell de significància és variable a posteriori, canviant l'anàlisi del test.
  ],
  [
    A priori: immòbil i rígida
  ],
  [
    Es pot canviar
  ],
  [
    Non-gradable: només $alpha$
  ],
)

== Rebutjar/No Rebutjar
#table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  stroke: 0.7pt,
  [*Fisher*], [*Neyman-Pearson*],
  [
    O rebutjes $H_0$ o no rebutjes $H_0$ per falta de proves.
  ],
  [
    O acceptes $H_P$ o acceptes $H_A$
  ],
  [
    Test de força (_significance test_): mesurem l'evidència per rebutjar $H_0$
  ],
  [
    Test d'acceptació (_acceptance test_): decidim entre hipòtesis $H_P$ i $H_A$
  ],
)

== Error de tipus I
#table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  stroke: 0.7pt,
  [*Fisher*], [*Neyman-Pearson*],
  [
    Tot l'experiment és _a posteriori_, per tant no importa si hi ha errors de tipus I.
  ],
  [
    No es pot saber amb només un intent del test, s'ha de considerar _in the long run_.
  ],
  [
    Es pot canviar a priori; recordar la Bonferroni quan volies fer diversos test.
  ],
  [
    S'ha de minimitzar durant el disseny de l'experiment (escollir la mínima $alpha$)
  ],
)
Tècnicament, Fisher no parla d'error tipus I, però la idea de no rebutjar $H_0$ quan s'havia de rebutjar és anàloga a l'error Tipus I de Fisher.

== Nivell de Significació ($alpha$)
#table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  stroke: 0.7pt,
  [*Fisher*], [*Neyman-Pearson*],
  [
    Segons el resultat i els valors del _p-value_
  ],
  [
    S'escull a priori i depen de l'experiment.
  ],
  [
    Test de força (_test of strength_): donem un grau de rebuig d'$H_0$ segons el nivell de significació.
  ],
  [
    Test d'acceptació (_acceptation test_), binari: Si $alpha in R_c arrow.double$ acceptem $H_A$; $alpha in.not R_c arrow.double$ acceptem $H_P$
  ],
)
Per exemple, amb un _p-value_ $p=5.43 times 10^(-4)$ amb un nivell de significació $s=0.05$, podem dir que el grau de rebuig de $H_0$ és alt, és a dir, molt probablement les dades de l'experiment no segueixen la distribució $H_0$. En canvi, no podem dir que $H_P$ s'accepta "amb força" o "pels pels" ja que és un test d'acceptació.

#v(2em)
== Glossari de Termes

#table(
  columns: (auto, auto),
  inset: 10pt,
  align: (left, left),
  stroke: 0.7pt,
  [*Terme*], [*Definició*],
  [*Hipòtesi nul·la* \
   (Null Hypothesis, $H_0$)], 
  [Hipòtesi que es vol contrastar o refutar. En Fisher, és la hipòtesi que es busca rebutjar amb evidència.],
  
  [*Hipòtesi alternativa* \
   (Alternative Hypothesis, $H_A$)],
  [En Neyman-Pearson, és l'alternativa a la hipòtesi principal. Representa una situació diferent a la proposada per $H_P$.],
  
  [*Mida de l'efecte* \
   (Effect size)],
  [Mesura que quantifica la magnitud d'un fenomen. En Neyman-Pearson, es considera explícitament en la formulació de les hipòtesis.],
  
  [*Error de tipus I* \
   (Type I error)],
  [Error que es comet en rebutjar la hipòtesi nul·la sent aquesta vertadera (fals positiu).],
  
  [*Error de tipus II* \
   (Type II error)],
  [Error que es comet en no rebutjar la hipòtesi nul·la sent aquesta falsa (fals negatiu).],
  
  [*Potència* \
   (Power)],
  [Probabilitat de rebutjar correctament la hipòtesi nul·la quan és falsa (1 - probabilitat d'error tipus II).],
  
  [*Regió crítica* \
   (Critical region)],
  [Conjunt de valors de l'estadístic que porten a rebutjar la hipòtesi nul·la.],
  
  [*Nivell de significació* \
   (Significance level, α)],
  [Probabilitat màxima d'error tipus I que estem disposats a acceptar.],
  
  [*Test de força* \
   (Test of strength)],
  [Enfocament de Fisher que mesura l'evidència contra la hipòtesi nul·la.],
  
  [*Test d'acceptació* \
   (Acceptance test)],
  [Enfocament de Neyman-Pearson que decideix entre dues hipòtesis alternatives.],
  
  [*MSE* \
   (Minimum Size Effect)],
  [Mínim efecte considerat significatiu en el context de l'estudi.]
)