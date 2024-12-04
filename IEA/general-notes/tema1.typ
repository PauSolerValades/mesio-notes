#import "math-template/template.typ": *
#show: sub_project

== Estimadors i Reducció de Dades

Primer defnim notació bàsica per esclarir-nos. Donada aquesta frase:

$Y_1,...,Y_n$ és una mostra, definida per $Y ~ f(bold(y), theta)$

#notation[
  - $Y_i$ és una variable aleatòria representant la mostra observada. No són encara dades, sinó com serien aquestes generades.
  - $Y$ és un vector aleatòri, és a dir, una variable aleatòria que representa la distribució, és a dir, una mostra de la distribució.
  - $Y ~ f(bold(y), theta)$ Y segueix una distribució amb densitat $f(bold(y), theta)$, i $bold(y)$ són les observacions $(y_1,...,y_n)$ (és a dir, dades conegudes d'avantmà) depenent del parametre $theta$.
]

#definition[Estadístic][
  Un *Estadístic* és una funció de la mostra $Y = (Y_1,...,Y_n)$ que no depen del parametre $theta$
]
Sobre $theta$, és un parametre que modifica la distribució de les dades. Si és conegut, sabem exactament com la població $Y$ es comporta. En general però, no s'acostuma a saber, i és l'objectiu d'aquest curs _estimar_ $theta$ correctament.

Per estimar un parametre, hem de fer tres distincions conceptuals:

#definition[Parametre a estimar][
  El Parametre a Estimar (o Estimand) és la quantitat que no coneixem i a la que volem donar-li valor, el que seria $theta$.
]

#definition[Estimador][
  Un *Estimador* és una funció que, donada la mostra, ens dona el valor de $theta$.
]

#definition[Estimació][
  La *estimació* d'un parametre és el valor que s'obté amb l'estimador corresponent.
]

És a dir, si $X = (X_1,...,X_n) ~N(mu, sigma^2)$ amb variància desconeguda i volem trobar la mitjana:
- Parametre a estimar: $theta = mu$ 
- Estimador: $accent(X, macron)$ és la funció que estima $theta$
- Estimand: El valor de $accent(X, macron) =  sum_(i=i)^n X_i/n = mu$ 

#definition[Estimador Puntual][
Un estimador puntual $hat(θ)$ de $θ$ és qualsevol funció mesurable de la mostra $(Y_1,...,Y_n)$ que no depèn de $θ$. Concretament, qualsevol estadístic és un estimador puntual.
]
Per exemple, $hat(θ) = hat(θ)(Y_1,...,Y_n) = 1/n sum_(i=1)^n Y_i$ és una variable aleatòria.
#definition[Estimació Puntual][
Una estimació puntual $hat(θ)$ de $θ$ és el resultat numèric del procés d'estimació, basat en els valors observats $(y_1,...,y_n)$.
]
Per exemple, $hat(θ) = hat(θ)(y_1,...,y_n) = 1/n sum_(i=1)^n y_i$ és un valor real.
La diferència clau és que:
- L'estimador puntual treballa amb variables aleatòries $(Y_1,...,Y_n)$
- L'estimació puntual treballa amb valors observats $(y_1,...,y_n)$

Tot i que ambós es denotin com $hat(θ)$, representen conceptes diferents: una funció (estimador puntual) vs. un nombre (estimació puntual)

== Versemblança

#definition[Versemblança][
  Donada una FMP (FDP) $f(bold(y)|theta)$ d'una mostra $Y = (Y_1,...,Y_n)$ i les observacions $bold(y) = (y_1,...,y_n)$, la funció de versemblança de $theta$ és
  $
    L(theta|bold(y)) = f(bold(y)|theta) = product_(i=1)^n f_Y (y_i | theta) 
  $
]

*Versemblança vs Probabilitat*

Aquí l'exemple de Poisson on es fan la mateixa pregunta a la inversa però obtens la mateixa resposta.

La diferència entre la probabilitat i la versemblança és només el teu coneixement a priori.
- Quina és la probabilitat de que $Y=3$ si $Y ~ #[Poiss] (2)$? És a dir, ja sabem que $lambda = 2$, i volem trobar com de probable és la nostra observació.
- Quina és "la probabilitat" de que les meves dades segueixen una Possion amb parametre $lambda = 2$ si la observació és $Y=3$? No sabem la distribució, concretament és el que volem estimar.

La versemblança ens respon la pregunta que volem contestar quan busquem un estimador: tenint les dades $bold(y)$ quin parametre $theta$ fa més versemblants les observacions? Com podem saber quins estimadors _maximitzen la versemblança_?

== Estimadors de Màxima Versemblança (MLE)

Recordem l'estimador del parametre $theta$ depen de les dades $Y_i$, i per tant, amb dades diferents seguint el mateix proces cada vegada, cosa no molt desitjable. En essència, tenim un vector aleatòri $(theta_1,...,theta_n)$ per cada vegada realitzem l'experiment. Denominarem $accent(theta, hat)_n$ a aquest vector, i tot sovint ometrem el subindex d'$n$, ja que no sempre importa la dimensió.

Per tant, $accent(theta, hat)$ és l'estimador de $theta$ desconegut.

#definition[MLE][
  Siguin $bold(y) in cal(Y)$ mostres de dades. Direm que el MLE $accent(theta, hat)$ de $theta$ és el valor de $Theta$ que maximitza la versemblança, és a dir:
  $
  accent(theta, hat) = arg max_(theta in Theta) L(theta|bold(y))
  $
]

#proposition[][
  Si $hat(theta)$ és el MLE de $theta$, aleshores per a qualsevol funció $g$ bijectiva, el MLE de $g(theta)$ és $g(hat(theta))$ TODO: COMPROVAR QUE AIXÒ ÉS AIXÍ, NO TINC REFERÈNCIES
]

En general sempre es vol trobar l'estimador de màxima versemblança (_Maximum Likelihood Estimator_) ja que tenen propietats òptimes i son bons estimadors. Per trobar bons estimadors necessitem definir:

#definition[Biaix][
  El biaix d'un estimador $accent(theta, hat)$ del parametre $theta$ és:
  $
  B_theta (accent(theta, hat)) = E_theta (accent(theta, hat)) - theta.
  $

  Direm que aquest estimador és no esbiaixat si $
  B_theta (accent(theta, hat)) = 0 arrow.double E_theta (accent(theta, hat)) = theta$
]

La interpretació del biaix d'un estimador és d'equivocar-se sistemàticament de la mateixa manera de $theta$.

Dues de les propietats necessaries que ha de tenir un estimador per ser considerat bo són:
#par(
  [
    + Biaix petit: en general l'estimador no s'equivoca, i si ho fa, el més petit possible. Concretament, si és no esbiaixat millor.
    + Variància petita: denotarem la variància $V_theta (accent(theta, hat, size: #(90%-10pt).length))$ // no sé què coi és el size ni com es fa servir
  ]

)

Aquestes dues propietats es condensen en l'expressió del *mean square error*

#definition[Mean Square Error (MSE)][
  La mitjana de l'error quadrat (MSE) és
  $
  #text[MSE]_theta (accent(theta, hat)) = E_theta ((accent(theta, hat) - theta)^2)
  $
]

#proposition[Càlcul del MSE][
  $
  #text[MSE]_theta (accent(theta, hat)) = V_theta (accent(theta, hat)) + B_theta (accent(theta, hat))^2
  $
  La demo està feta a l'annex pàgina 1
]

A tall de reflexió, no sempre el millor estimador és un no esbiaixat, com per exemple l'exemple 1.4 dels apunts de la Lupe.
Allà es calcula el MLE d'una mostra seguint una normal, i es veu que el MSE de l'estimador no esbiaixat no és el mateix que el MLE per la variància.

Tot i l'exemple anterior, la intuïció de cercar el millor estimador $accent(theta, hat)_n$ d'entre tots els no esbiaixats és correcta, ja que trobar propietats d'entre el conjunt d'estimador que minimitzen l'MSE però son no esbiaxiats és difícil. Per tant, essent $tau(theta)$ una reparametrizació, definim
$cal(C)_theta = {W: E_theta (W) = tau (theta)}$, on W representa l'estimador (el que fins ara ha estat $accent(theta, hat)_n$) del parametre $theta$ d'entre tots els estimadors no esbiaixats.

#definition[Uniform Minimum Variance Unbiased Estimator (UMVUE)][
  Un estimador $W^*$ és el millor estimador de $tau(theta)$ si
  #par(
    [
      + $E_theta (W^*) = tau (theta) forall theta in Theta$ (equivalenment $W^* in cal(C)_theta$)
      + $forall W in cal(C)_theta : W != W^*$ compleix $V_theta (W^*) <= V_theta (W)  forall theta in Theta$
    ]
  )
]

== Estadístics Suficients

En aquest apartat es tractarà el process de reducció de dades i la manera de trobar-ne un representat adequat.

#definition[Sufficient Statistic][
  Sigui $T$ un estadístic. S'anomena a $T$ estadístic suficient si
  #par(
    [
      + la distribució condicional de la mostra $bold(X)$ donat el valor $T(X)$ no depen de $theta$.
      És a dir, sent $g(t)$ funció no depenent de $theta$
      + Si la llei d'$bold(X)$ és discreta: $P(X=x|T=t; theta) = g(t)$
      + Si la llei és continua: $f_(bold(X)) (bold(x)|T=t;theta) = g(t)$
    ]
  )
]

Un estadístic $T$ és suficient per a $theta$ (abreujat com a SSt a partir d'ara) si tot a inferència sobre el parametre $theta$ depen de la mostra $bold(X) = (X_1,...,X_n)$ només segons el valor de $T(bold(X))$

El raonament darrera d'aquesta definició és que ens permet definir el *Principi de Suficència*: donats dos conjunts de dades $bold(x), bold(y)$ tals que $T(x) = T(y)$, aleshores tota inferència de $theta$ ha de ser la mateixa per a tots dos conjunts de dades. És a dir, $T$ és SSt per als dos, significa que les dades "es comporten igual" i per tant, només usant $T$ hem d'obtenir les mateixes conclusions tant per $bold(x)$ com per $bold(y)$.

*Nota:* L'estadístic suficient NO és únic, poden haver-hi més d'un que complieixin les condicions

Aleshores, el que interessa és trobar un mètode efectiu per determinar si un estadístic depen o no del paràmetre, i el següent teorema ens hi dona resposta:

#theorem[Factoritzation Theorem][
  Sigui $f_bold(X) (bold(x)|theta)$ la distirbució conjunta de $X=(X_1,...,X_n)$. L'estadístic $T(X)$ és SSt de $theta$ sii existeixen $g(t;theta)$ i $h(x)$ tal que $forall bold(x) in cal(X), theta in Theta$ podem escriue
  $
  f_bold(X) (bold(x)|theta) = g(T(X); theta) h(x)
  $
]

== Teoremes de Rao-Blackwell i Lehman-Scheffé
_Aquí entrariem ara a CramerRao i a lehman sheffé per trobar l'UMVUE i la lògica que segueix, però per el midterm no ho escriuré en detall ja que és massa teòric per l'aplicació que se l'hi dona (literalment aplicar-ho)_

== Teorema i Cota de Cramer Rao

Per operar amb prestesa la Cramer Rao bound, necessitem primer entendre (i operar) amb els següents conceptes sobre la *informació de Fisher*

*Intuïció* La informació de fisher és "el contrari" de la variància, a més informació de fisher tingui $X$ VA, més sabrem sobre la distrbució que segueix $X$. Considerem el següent exemple:

#example[Informació de Fisher][
Considerem una variable aleatòria $X$ que representa les notes dels alumnes d'un país de la Unió Europea, on el nostre objectiu és determinar de quin país provenen aquestes notes. Assumim que disposem d'una mostra de mida equivalent i suficientment gran per a tots els països, de manera que $X ~ cal(N)(mu, sigma^2)$.
Paradoxalment, quan $sigma^2$ és molt petita (la variància s'apropa a zero), la informació de Fisher també tendeix a zero. Per entendre això, considerem un exemple pràctic:
A Alemanya, les notes van de l'1 al 5, mentre que a Catalunya van del 0 al 10. Suposem que tenim una mostra amb $sigma^2 = 0$ i $mu = 5$. En aquest cas, tots els estudiants han obtingut exactament un 5, i no podem determinar l'origen de les dades: podria ser tant un excel·lent a Alemanya com un aprovat just a Catalunya.
D'altra banda, quan la variància augmenta (és a dir, $sigma^2$ creix), obtenim més informació sobre la distribució subjacent de les dades. Això ens permet identificar millor el sistema d'avaluació utilitzat i, per tant, el país d'origen de les notes.

Per tant, la informació de Fisher a més gran (proporcional a la variància) més insight ens dona sobre les dades
]

Denotarem amb $l(theta|bold(x)) = log L(theta|bold(x))$, ja que s'usa constantment en practicament tots els casos.

#definition[Puntuació (Score Function)][
  Anomenem la Puntuació (score function) a la primera derivada de $l(theta|bold(x))$
  $
    S_bold(X)(theta) = S(theta|bold(X)) =  frac(partial, partial theta) l(theta|bold(X))
  $
]


#definition[Informació de Fisher][
  La informació de fisher que $X$ té sobre $theta$ és 
  $
    i_bold(X) (theta) = frac(partial, partial theta) S(theta|bold(X)) = - frac(partial^2, partial^2) l(theta|x)
  $
]

#definition[Observed Fisher's Information][
  És el mateix que la informació de fisher però amb $i_bold(X)(accent(theta, hat)_"MLE" (bold(x)))$.
]

#definition[Expected Fisher's Information][
  La informació esperada de fisher que $X$ té sobre $theta$ és
  $
    I_bold(X)(theta) = E_theta (i_X(theta))
  $ 
]

En general, $I_bold(X) (theta)$ ser la més útil i la que dona més informació, és també a vegades molt difícil de calcular a la pràctica i s'acaba usant $i_bold(X) (theta)$

