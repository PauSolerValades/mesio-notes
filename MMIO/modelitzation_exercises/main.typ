#let homework(title, name, subject, date, body) = {
  // Set the document's basic properties
  set document(author: name, title: title)
  set page(
    numbering: "1",
    number-align: center,
    margin: (left: 2cm, right: 2cm, top: 2cm, bottom: 2cm),
  )
  set text(font: "New Computer Modern", size: 11pt)

  // Title row
  align(center)[
    #block(text(weight: 700, size: 1.5em)[#title])
    #v(0.5em)
    #block(text(size: 1.25em)[#subject])
    #v(0.5em)
    #block(text(size: 1.1em)[#name])
    #v(0.5em)
    #block(text(size: 1.1em)[#date])
  ]

  // Main body
  v(4em)
  par(justify: true)[#body]
}

#show: doc => homework(
  "Exercicis de Modelització",
  "Pau Soler Valadés",
  "Models i Mètodes de la Investigació Operativa (MMIO)",
  "September 15, 2024",
  doc
)
#let Im = $text("Im")$

= La dieta
Donada la seguent taula d'aliments, el seu cost i els seu valor nutricional

#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: (left, right, right, right, right, right, right),
    stroke: 1pt,
    inset: 8pt,
    [*Food Item*], [*Bread*], [*Milk*], [*Cheese*], [*Potato*], [*Fish*], [*Yogurt*],
    [Cost], [2.0], [3.5], [8.0], [1.5], [11.0], [1.0],
    [Protein, g], [4.0], [8.0], [7.0], [1.3], [8.0], [9.2],
    [Fat, g], [1.0], [5.0], [9.0], [0.1], [7.0], [1.0],
    [Carbohydrates, g], [15.0], [11.7], [0.4], [22.6], [0.0], [17.0],
    [Calories], [90], [120], [106], [97], [130], [180]
  )
]

Troba el conjunt d'elements més econonòmic tal que compleixin

#set align(left)
#pad(
  left: 1em,
  [
    - Al menys 300 calories
    - No més de 10 grams de proteïna
    - Al menys 10 grams de carbohidrats
    - Al menys 8 grams de greix
    - Al menys 0.5 unitats de peix
    - No més d'1 unitat de llet
  ]
)

== Solució

Sempre que hem de modelitzar un problema hem de definir clarament les seves 3 parts principals:
#pad(
  left: 1em,
  [
    + Variables: de quina informació disposem al problema per poder modelitzar-lo. És la part més creativa, ja que un problema es pot resoldre diferent segons quines variables s'escullin.
    + Restriccions: quines restriccions hem d'imposar a les variables escollides.
    + Funció Objectiu: com interactuen les variables, i quines hem de maximitzar o minimitzar. Bàsicament, què volem aconseguir en aquest problema.
  ]
)

=== Variables
Definim:
#pad(
  left: 1em,
  [
    + $I = {1,...,n}$ conjunt de menjar a escollir, sent $i$ l'ítem. En el nostre problema, $n=6$
    + $forall i in I, c_i$ és el cost associat al menjar $i$
    + $forall i in I, x_i$ és la quantitat en grams del menjar $i$
    + $J = {1,...,m}$ conjunt de característiques extra de tots els aliments a comprovar. És a dir, 1 son els carbohidrats, 2 els greixos, 3 les calories... Per tant, $j in J$ és un atribut. 
    + És a dir, anomenem $y_(i j)$ la quantitat de $j$ que té l'ítem $i$. Per exemple, el Pa (i=1) té 4 grams de proteïna, ergo $y_(1 1) = 4$, i les calories del formatge, serien $y_(3 4) = 106$ 
    + $R = {r_1,...,r_q}$ el conjunt de restriccions, és a dir, què no es pot complir. Un $r in R$ qualsevol conté una relació entre $j$ i el total. Per exemple, menys de 300 grams de proteina, seria $r = {1, <, 300}$.
  ]
)

=== Funció Objectiu:
És clar que amb 1,2 i 3 ja podem definir la funció objectiu, que és minimitzar:
$
sum_(i in I)x_i c_i
$

=== Restriccions
Seguint la notació introduïda a les variables, tindriem:
#pad(
  left: 1em,
  [
    + $sum_(i in I) y_(i 3) x_i >= 300$ (calories)
    + $sum_(i in I) y_(i 1) x_i <= 10$ (proteïna)
    + $sum_(i in I) y_(i 4) x_i >= 10$ (carbohidrats)
    + $sum_(i in I) y_(i 2) x_i >= 8$ (greix)
    + $x_5 >= 0.5$ (peix)
    + $x_2 <= 1$ (llet)
    + $x_i >= 0$ $forall i in I$ (no negativitat)
  ]
)

On dels ítems 1 al 6 es podrien reescriure com a elements de $R$, i el 7 fa no negativitat.

= Mapa de Colors
Donat un mapa, troba el menor nombre de colors que permet pintar el mapa tal que no hi ha dos països contiguus amb el mateix color.

=== Parametres i Conjunts
#pad(
  left: 1em,
  [
    + $I = {1,...,n}$ el nombre de països que està contingut pel mapa.
    + $I_i subset I$, concretament, $I_i$ són els veïns (països contigus) al país $i$
    + $J = {1,...,m}$ són els colors disponibles.

  ]
)

=== Variables
#pad(
  left: 1em,
  [
    + Variable d'ús de colors, 
    $
    y_j = cases(
      1 "si el color j està pintant algun país",
      0 "altrament"
    )
    $
    + Variable binària de relació 
    $
    x_(i j) = cases(
      1 "si el país i està pintat amb el color j",
      0 "altrament"
    )
    $
  ]
)
=== Funció Objectiu
Volem minimitzar

$
sum_(j in J) y_j
$

=== Restriccions
1. S'ha d'usar com a mínim un color, no pots no pintar cap país: 
$
sum_(j in J) y_j >= 1
$
2. Un país ha d'estar pintat per només un únic color:
$
sum_(j in J) x_(i j) = 1
$
3. Donat el país $i$, si aquest està pintat amb el color $j$, aquest no pot estar a cap dels seus veïns:
$
j in J, k in I_i, x_(k j) + x_(i j) <= 1
$
Aquesta última és la restricció complicada de deduïr. Hi ha dos detalls lògics importants:
#pad(
  left: 1em,
  [
    + Que la condició compleixi per a tot veí de $i$ no és $ sum_(k in I_i) ...$ sinó que imposant les condicions dos a dos ja funciona, és a dir: $forall k in I_i ...$, per tant és lineal.
    + Ha de ser menor o igual que 1, dient-nos que si passa una, no passa l'altre i que quan passen les dues és impossible, com aquesta taula de veritat:

    #align(center)[
      #table(
        columns: (auto, auto, auto, auto),
        align: (center, center, center, left),
        stroke: 1pt,
        inset: 8pt,
        [*$x_(k j)$*], [*$x_(i j)$*], [*Suma*], [*Interpretació*],
        [0], [0], [0], [No es fa servier el color j ni a i ni als veïns (Factible)],
        [0], [1], [1], [El país $i$ té color $j$ i el veí $k$ tampoc (Factible)],
        [1], [0], [1], [El veí $k$ té el color $j$ i el país $i$ no (Factible)],
        [1], [1], [2], [Ambdós països pintats amb color j (Impossible)],
      )
    ]
  ]
) 

= Vigilant de Museu
Pensar i escriure

= Mínim cost en un graf dirigit

Donat un graf dirigit amb demanda (un conjunt d'usuaris volen anar d'un punt a un altre), costos (com de llarg és el camí) i capacitat (quants usuaris poden anar a la carretera en un moment determinat), troba el camí amb cost mínim per enviar flux per la xarxa.

=== Variables
Definim:
- $G = (N,A)$ graf dirigit
- $N = {1,...,n}$ nodes
- $A = {(i,j) | i,j in N}$ vertexs
- Demanda: $b in RR^m$ $forall i in N$
- Cost: $c in RR^m$ $forall (i,j) in A$ $c_(i j)$
- Capacitat: $d in RR^m$ capacity $(i,j) in A$
- Variable $x_(i j)$: flux pel vertex que uneix els nodes $i,j$

=== Funció Objectiu
Volem trobar el mínim cost d'enviar el flux per la xarxa, per tant:

$
min sum_(i,j in A) c_(i j) x_(i j)
$

=== Restriccions
1. Conservació del flux: per a un node qualsevol $i in N$, tot el flux que li ha arribat quan s'ha acabat el problema, ha de ser la seva demanda. Això s'escriu tal que així:
   $
   sum_({j:(i,j) in A}) x_(i j) - sum_({j:(j,i) in A}) x_(j i) = b_i quad forall i in N
   $
   Concretament, $sum_({j:(i,j) in A}) x_(i j)$ és tot el flux dels veïns que apunten a $i$, i $sum_({j:(j,i) in A}) x_(j i)$ és tot el flux que surt del node $i$. La resta d'aquests dos termes ha de ser la seva demanda $b_i$. És a dir, si és un node de pas ($b_i = 0$), el flux d'entrada és igual al de sortida, però si és un destí o un origen, les quantitats no seran iguals.

2. Capacitat i no negativitat: no pots enviar més flux en un vertex que la seva capacitat.
   $
   0 <= x_(i j) <= d_(i j) quad forall (i,j) in A
   $


3. Suma de demandes: s'imposa que s'ha de satisfer tota la demanda.
   $
   sum_(i in N) b_i = 0
   $

= Màxim flux en un graf dirigit

Donat un graf dirigit amb les característiques del problema anterior, ara deteminem els nodes $s, t in N$, sent $s$ l'inici (_source_) i $t$ el final (_taget_) que son l'inici i el final de la demanda. El problema ara és de maximització del flux del node $s$ al node $t$ mai superant les capacitats de la xarxa.

=== Variables
Definim $G, N, A, d, x_(i j)$ exactament igual que el problema anterior, i fem notar que no necessitem ni $c$ ni $b$, ja que el problema només parla de maximitzar el flux entre dos nodes, no de reduïr el cost

De segur, ens falta la variable flux, que denominarem $v_(i j)$ com a volum. Concretament, el nostre problema, direm directament $v = v_(s n)$

=== Funció Objectiu
La funció objectiu és doncs, clarament, la maximització de v
$
max v
$

=== Restriccions
Ara ja no estem fent servir tots els nodes, i el matís d'aquest problema està en la distinció del node d'inici i el node fi dels altres.
1. Restricció de capacitat: aquesta val per a tot vertex, mai es pot superar la capcitat d'un vèrtex.
$
0 <= x_(i j) <= d_(i j) quad forall (i, j) in A
$
2. Igualtat de flux: tot el flux que entra en un node, ha de sortir d'aquest mateix, a menys que el node sigui $s$ o $t$.
$
sum_{j: (i,j) in A} x_(i j) = sum_{j: (j, i) in A} x_(i j) quad forall i in N without {s, t}
$
3. Flux de sortida de $s$: tot el flux que surt d'$s$ és el maxim flux de la xarxa, ja que s és l'únic inici
$
sum_(j:(s,j) in A) x_(s j) = v
$
4. Flux d'entrada a $t$: tot el flux que arriba a $t$ és el màxim flux de la xarxa, ja que només pot sortir per $t$.
$
sum_(j:(j,t) in A) x_(j t) = v
$

= Ubicació d'hospitals
Donat un conjunt de potencials ubicacions d'hospitals, troba la millor permutació de $P$ hospitals tal que la distància dels usuaris més llunyans de l'hospital sigui mínima. És a dir, el pitjor cas (la persona que està més lluny de l'hospital) ha de ser el menor possible.

== Intuïció i Raonament
Obviament, la dificultat d'aquest problema està en que, sense imposar que sigui lineal, la funció objectiu intuïtiva és:

$
min max d_(i j) forall i in I
$

És a dir, el mínim de les distàncies dels usuaris que estan més lluny donat un hospital. No cal dir que això no és lineal.

== Solució 1
Aquesta és la solució que se l'hi va acudir a l'autor i que conté una tècnica de modelització interessant, tot i que després es reescriu simplificada en la solució 2.

=== Conjunts i Paràmetres
#pad(
left: 1em,
[
+ $I = {1,...,n}$ usuaris disponibles
+ $J = {1,...,m}$ ubicacions de possibles hospitals
+ $d_(i j)$ distancia entre l'usuari $i$ i l'hospital $j$
+ $P$ nombre d'hospitals que s'han d'obrir
]
)

=== Variables
#pad(
left: 1em,
[
+ Quins hospitals tenim oberts:
$
y_j = cases(
1 "si l'hospital" j "és obert",
0 "al contrari"
)
$

+ Quin usuari va a quin hospital:
$
Z_(i j) = cases(
1 "si el client" i "està assignat a l'hospital" j,
0 "viceversa"
)
$

+ Indicador de l'usuari més llunyà donat un hospital:
$
X_(j i) = cases(
1 "si l'usuari" i "és el més llunyà de l'hospital" j,
0 "altrament"
)
$
]
)

=== Funció Objectiu
Minimitza la distància màxima:
$
min sum_(j in J) sum_(i in I) d_(i j) X_(j i)
$

=== Constraints
1. Hem d'obrir exactament P hospitals:
$
sum_(j in J) y_j = P
$

2. Cada usuari pot acudir a un sol hospital:
$
sum_(j in J) Z_(i j) = 1 quad forall i in I
$

3. Un usuari només pot ser assignat a un hospital que estigui obert:
$
Z_(i j) <= y_j quad forall i in I, j in J
$

4. Elecció de la màxima distància:
$
d_(k j)Z_(k j) <= d_(i j)Z_(i j) + M(1 - X_(j i)) quad forall i,k in I, j in J
$
Aquesta restricció una "$M$", on aquesta és una constant suficientment gran, com per exemple la distància més gran entre un usuari i un hosptial. Quan $X_(j i) = 1$, l'equació ens assegura que per l'usuari $i$ aquesta és la distància més llarga; quan és zero, mai ho pot ser perque la constant M ens assegura que qualsevol $d_(k j)$ será com a mínim $M$ vegades més petita. Aquest truc ens permet ser molt flexibles amb la distància, ja que el valor d'$M$ es fixa d'avantmà.

5. Un usuari només pot ser el més llunyà per un hosptial si l'usuari està assignat a aquell hospital:
$
X_(j i) <= Z_(i j) quad forall i in I, j in J
$

== Solució millorada
La solució 1 és perfectament correcta, tot i que en aquest cas, n'existeix una altra molt més elegant, que passa per canviar la funció objectiu i eliminar una variable. Aleshores, deixant exactament els mateixos parametres que ja teniem, defninim:

=== Funció Objectiu
Com que seguim volent fer un maxim d'un mínim, escribim:
$
min z
$

com a funció objectiu.

== Variables
Només necessitem les variables $y_(i j)$ i $Z_(i j)$

== Restriccions

1. $z$ ha de ser el valor més gran possible.
$
z >= d_(i j)Z_(i j) quad forall i in I, forall j in J
$
Això és equivalent a que la distància sigui màxima.

Les restriccions 1. 2. i 3. anteriors es mantenen exactament igual, i s'eliminen la 4 i la 5.


= Common Mathematical Programming Tricks

=== Big-M Method
When we need to activate/deactivate constraints or model logical implications:
#pad(
left: 1em,
[
+ Basic form:
$
a <= b + M(1-x) quad x "binary"
$

+ For "if x = 1 then a <= b":
$
a <= b + M(1-x)
$
When x = 1, becomes a <= b
When x = 0, constraint is relaxed
]
)

=== Either-Or Constraints
For modeling "either constraint A or constraint B must hold":
#pad(
left: 1em,
[
+ Example: either $a <= 5$ or $b <= 3$:
$
a <= 5 + M_1 y
$
$
b <= 3 + M_2(1-y)
$
$
y "binary"
$
]
)

=== Min/Max Linearization
To model z = min(x,y):
#pad(
left: 1em,
[
$
z <= x
$
$
z <= y
$
$
z >= x - M(1-w)
$
$
z >= y - M w
$
$
w "binary"
$
]
)

=== Absolute Value
For modeling z = |x|:
#pad(
left: 1em,
[
$
x = p - n
$
$
z = p + n
$
$
p,n >= 0
$

Where p represents the positive part and n the negative part of x
]
)

=== Fixed Costs
For problems with setup costs and variable production:
#pad(
left: 1em,
[
$
"production" <= M dot y
$
$
"cost" = "fixed_cost" dot y + "variable_cost" dot "production"
$
$
y "binary"
$
]
)

=== Notes
+ M should be a sufficiently large constant but not too large to avoid numerical issues
+ These patterns can be combined to model more complex logical relationships
+ Choice of M is important: too small might cut off feasible solutions, too large might cause numerical instability