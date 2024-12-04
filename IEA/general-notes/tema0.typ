#import "math-template/template.typ": *
#show: sub_project

== Espai de Probabilitats

#definition[Espai de Probabilitat][
  Un espai de Probabilitat és una terna $(Omega, cal(A), P)$ on 
  - $Omega$ _espai mostral_: conté tots els possibles resultats de l'experiència aleatòria.
  - $cal(A)$ _esdeveniments possibles_: familia de parts d'$Omega$ ($cal(A) subset cal(P(Omega))$) que té estructura de $sigma$-àlgebra, que vol dir que és una $sigma$-àlgebra si compleix que
  #set enum(indent: 2em)
  1. $Omega in cal(A)$
  2. $cal(A)$ és estable per pas al complementari ($A in cal(A) => A^c in cal(A)$)
  3. $cal(A)$ es estabale per unions numberables (${A_n, n>= 1} subset cal(A) => union_(n>=1)A_n in cal(A)$)
  - $P$ probabilitat: assigna versemblança a un element d'$cal(A)$. $P: cal(A) arrow.r.long [0,1]$. $P$ compleix:
  1. $P(Omega) = 1$
  2. $P(union_(n>=1)^inf A_n) = sum_(n=1)^inf P(A_n)$

]

Recordatori ràpid de les propietats de la probabilitat $P$:
#set enum(indent: 2em)
1. $P(emptyset) = 0$
2. $sigma$-additivitat implica additivitat finita. És a dir, la probabilitat de que $n$ esdeveniments suceeixin és la suma de les seves probabilitats si els esdeveniments son disjunts. Si aquests no fossin disjunts, la probabilitat seria major o igual, en comptes d'igual.
3. $forall A in cal(A) P(A^c)=1-P(A)$
4. $A,B in cal(A), A subset B => P(A) <= P(B)$
5. $P(A union B) + P(A sect B) = P(A) + P(B)$

I també de les altres dues grans eines de la probabilitat:

#definition[Probabilitat Condicionada][
  La probabilitat de que $A in cal(A)$ estigui condicionada per $B in cal(A)$ és

  $
  P(A|B) = frac(P(A sect B), P(B))
  $
]

I se'n deriva inmediatament el següent

#proposition[Formula Probabilitats Compostes][
  Siguin $A_1,...,A_n in cal(A) | P(A_1 sect ... sect A_n) > 0$. Aleshores,

  $
  P(A_1 sect ... sect A_n) = P(A_1)P(A_2|A_1)...P(A_n|A_1 sect ... sect A_(n-1))
  $
]

#proposition[Fórmula de Bayes][
  Siguin $A, B$ dos esdeveniments de probabilitat no nuls, es compleix que

  $
  P(A|B) = frac(P(A sect B), P(B)) = P(B|A)frac(P(A), P(B))
  $
]

== Variables Aleatòries

A nivell matemàtic és incòmode treballar amb $omega in Omega$, ja que els elements son bastant arbitràris. Per a tenir quelcom més uniforme, tractem amb variables aleatòries.

#definition[$sigma$-àlgebra de Borel][
  Denotem amb $cal(B)$ la $sigma$-àlgebra de Borel, que és la generada pels conjunts oberts d'$RR$. És a dir, $cal(B)$ és la $sigma$-àlgebra de $cal(P)(RR)$ que conté tots els oberts d'$RR$ respecte la topologia euclidiana.
]

#definition[Variable Aleatòria][
  Una *Variable aleatòria* és una aplicació $X: Omega arrow.r.long RR$ que compleix la condició de _mesurabilitat_, que és la següent:
  $
  forall B in cal(B), X^(-1)(B) in cal(A)
  $
]

La condició de mesurabilitat de la variable aleatòria permet assignar un valor numèric a qualsevol $omega in Omega$ de la següent manera:

$ 
P(X^(-1)(B)) = P{omega in Omega in B}, forall B in cal(B) 
$

I per tant $X: Omega arrow.r.long RR$ és una variable aleatòria.

#proposition[Propietats de les variables aleatòries][
  Les propietats de les variables aleatories són, sent $X, Y $ variables aleatòries:
  - $a X + b Y, X Y$ també son variables aleatòries
  - $max(X,Y), min(X,Y)$ són variables aleatòries
  - $X/Y$ és variable aleatòria si $0 in.not Im(Y)$
  - L'ínfim, el suprem, el límit de l'ínfim i del suprem son variables aleatòries donada una successió de variables aleatòries
  - Tota variable aleatòria no negativa és el límit creixent d'una successió de variables aleatòries simples positives.
]

== Llei d'una Variable Aleatòria

Si les variables aleatòries et permeten assignar valors numèrics a elements de l'espai mostral, les lleis d'una variable aleatòria et permeten assignar probabilitats a aquests esdeveniments.

#definition[Llei d'una Variable Aleatòria][
  La llei d'una variable aleatòria $X$ és la probabilitat sobre $(RR, cal(B))$, que anomenarem $Q$ definida de la següent manera:

  $
  forall B in cal(B), Q(B) = P(X^(-1)(B)) | X^(-1)(B) = {omega, X(omega) in B}
  $

  per tant, $Q = P compose X^(-1)$ i clarament $Q: cal(B) -> [0,1]$
]

Es demostra trivialment que $Q$ és una probabilitat sobre $(RR, cal(B))$.

Per tant, amb aquesta definició hem aconseguit passar de l'espai de probabilitat $(Omega, cal(A), P)$ a l'espai de probabilitat numèric $(RR, cal(B), P compose X^(-1)$. Aquests segons espais son els que, per defecte, es fan servir quan es parla de probabilitats.

#definition[Funció Distribució][
  La funció de distribució associada a una variable aleatòria $X$ és la funció $F: RR arrow.r.long [0,1]$ definia per
  $
  F(x) = P compose X^(-1)((- infinity, x])
  $
]

#remark[Inducció de Probabilitat a X][
  Ara mateix, tenim dos espais de probabilitat, el numèric i el tradicional. El que s'aconsegueix amb la llei i la composició de les funcions és operar amb el millor dels dos mons. És a dir, la _mesurabilitat_ de les variables aleatòries ens garanteix que quan volguem calcular la probabilitat d'un element a la recta real (i per tant membre de la $sigma$-àlbegra $cal(B)$) aquest SEMPRE equivalgui a un element a l'espai mostral $Omega$. 

  Per tant *tota variable aleatòria $X$ indueix una probabilitat a $(RR, cal(B))$*, i aquesta probabilitat induïda és $Q$, la llei d'una variable aleatòria. És a dir, quan informalment volem calcular $P(B), B in cal(B)$ (sent P aquí la idea de "probabilitat") d'una variable aleatòria, en realitat estem fent 
  $
  Q(B) = P compose X^-1(B) = P({omega, X(omega) in B})
  $
  
  unint l'espai numèric de probabilitat amb l'espai de probabilitat normal. Això és el que volem dir amb que $X$ indueix una probabilitat a $(RR, cal(B))$.

  Per acabar, quan parlem de funció de distribució, seria l'equivalent a la Llei de la variable aleatòria però a la recta real.
]

#proposition[Propietats Funció Distribució][
  Sigui $F$ la funció de distribució d'una variable aleatòria $X$. Es compleix que:
  1. F és creixent
  2. F és contínua per la dreta ($lim_(x arrow.r a^-)F(x) = F(a)$)
  3. $lim_(x arrow infinity)F(x) = 1$ i $lim_(x arrow - infinity)F(x) = 0$
]

Concretament, tot i existir $lim_(y arrow.r x^-) F(y) forall c in RR$, el que no podem esperar es que $F(x^-) = F(x) forall x in RR$, és a dir, $F$ té discontinuïtats de primera espècie, i al ser acotada, té un nombre finit d'aquestes discontinuïtats.

El que ens dona la funció de disctribució de variables aleatòries és la capacitat de calcular les probabilitats a través d'aquesta. Siguin $F_X$ la funció de distribució de la variable aleatoria $X$ i $P_X$ la probabilitat induïda per aquesta. Aleshores:

$
F_X(x) = P_X ((-infinity,x]) = P(X^(-1)(-infinity, x]))) = P({omega, X(omega) in B}) = P(X <= x)
$

I des d'aquí, podem obtenir les següents probabilitats naturalment des de $F$:
- Probabilitat d'un obert d'$RR$: $P((a, b]) = P(a < X <= b) = F_X (b) - F_X (a)$
- Probabilitat de la unió d'oberts d'$RR$: $P(union_(i=1)^infinity (a_i, b_i]) = sum_(i=1)^infinity P((a_i, b_i])$
- Probabilitat d'un punt d'$RR$: $P(X=x) = F(x)- F(x^-) $

=== Variables Aleatòries Discretes

Aquí posarem tots els tipus de distribucions per repassar amb les seves lleis, però sento que aquesta gent té bastanta més pressa ara per ara.

=== Variables Aleatòries Absolutament Contíunes

#definition[Densitat][
  Una funció $f$ és una densitat si compleix:
  1. $f>= 0$
  2. $f$ és integrabe Riemann a $RR$
  3. Es té que:
  $
  integral_(-infinity)^(infinity)f(x) d x =1
  $
]

Aleshores, amb la densitat podem definir:

#definition[Variable Aleatòria Abolutament Contínua][
  Una variable aleatòria $X$ és absolutament contínua amb densitat $f$ si la funció de distribució es pot escriure com:
  $
    F(x) = integral_(-infinity)^(x)f(y) d y
  $
  on $f$ és una densitat.
]

I des de la definició, és inmediat que:

$
P(X in I) = integral_(a)^(b)f(x) d x, I in {[a,b], (a,b), [a,b), (a,b]}
$

No tota variable contínua és absolutament contíuna, però el revers sí que és cert.

== Densitats de transformacions de Variables Aleatòries

Pàgina 71 pdf Marta Sanz, com es fa Això