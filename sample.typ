#import "template.typ": *
#import "formal_method_template.typ": proof

(1) #proof(
  $(p and q) and r$, [p],
  $s and t$, [p],
  $p and q$, [$and e_1$ 1],
  $q$, [$and e_2$ 3],
  $s$, [$and e_1$ 2],
  $q and s$, [$and i$ 4,5]
)

#line(length: 100%)

(2) #proof(
  $q->r$, [p],
  [+], 5,
  $p->q$, [a],
  [+], 3,
  $p$, [a],
  $q$, [$-> e$ 2,3],
  $r$, [$-> e$ 1,4],
  $p->r$, [$-> i$ 3-5],
  $(p->q)->(p->r)$, [$-> i$ 2-6],
)

#line(length: 100%)

(3) #proof(
  [+], 8,
  $q$, [a],
  [+], 6,
  $p$, [a],
  [+], 4,
  $p$, [a],
  [+], 2,
  $q$, [a],
  $p$, [Copy 3],
  $q->p$, [$-> i$ 4-5],
  $p->(q->p)$, [$-> i$ 3-6],
  $p->(p->(q->p))$, [$-> i$ 2-7],
  $q->(p->(p->(q->p)))$, [$-> i$ 1-8]
)

#pagebreak()

(4) #proof(
  $p->q and r$, [p],
  [+], 3,
  $p$, [a],
  $q and r$, [$-> e$ 1,2],
  $q$, [$and e_1$ 3],
  $p->q$, [$-> i$ 2-4],
  [+], 3,
  $p$, [a],
  $q and r$, [$-> e$ 1,6],
  $r$, [$and e_2$ 7],
  $p->r$, [$-> i$ 6-8],
  $(p->q) and (p->r)$, [$and i$ 5,9]
)

#line(length: 100%)

(5) #proof(
  $p and not p$, [p],
  $p$, [$and e_1$ 1],
  $not p$, [$and e_2$ 1],
  $bot$, [$not e$ 2,3],
  $not(r -> q) and (r -> q)$, [$bot e$ 4]
)

#pagebreak()

(6) #proof(
  $exists x(S->Q(x))$, [p],
  [+], 5,
  $S$, [a],
  [+], 3,
  $x_0$, [x],
  $S->Q(x_0)$, [a],
  $Q(x_0)$, [$-> e$ 3,2],
  $exists x Q(x)$, [$exists x space i$ 4],
  $exists x Q(x)$, [$exists x space e$ 1,3-5],
  $S->exists x Q(x)$, [$-> i$ 2,6]
)

#pagebreak()

(7) #proof(
  $forall x P(x) -> S$, [p],
  [+], 24,
  $not exists x(P(x) -> S)$, [a],
  [+], 18,
  $x_0$, [x],
  $$, [],
  [+], 3,
  $P(x_0)->S$, [a],
  $exists x (P(x)->S)$, [$exists x space i$ 4],
  $bot$, [$not e $ 5,2],
  $not (P(x_0)->S)$, [$not i$ 4-6],
  [+], 5,
  $S$, [a],
  [+], 2,
  $P(x_0)$, [a],
  $S$, [Copy 8],
  $P(x_0)->S$, [$-> i$ 9-10],
  $bot$, [$not e$ 11,7],
  $not S$, [$not i$ 8-12],
  [+], 6,
  $not P(x_0)$, [a],
  [+], 3,
  $P(x_0)$, [a],
  $bot$, [$not e$ 15,14],
  $S$, [$bot e$ 16],
  $P(x_0)->S$, [$->i$ 15-17],
  $bot$, [$not e $ 18,7],
  $P(x_0)$, [PBC 14-19],
  $forall x not S$, [$forall x space i$ 3-13],
  $not S$, [$forall x space e$ 21],
  $forall x P(x)$, [$forall x space i$ 3-20],
  $S$, [$-> e$ 1,23],
  $bot$, [$not e$ 24,22],
  $exists x (P(x)->S)$, [PBC 2-25]
)

#pagebreak()

(8) #proof(
  $forall x(P(x) and Q(x))$, [p],
  [+], 2,
  $x_0$, [x],
  $P(x_0) and Q(x_0)$, [$forall x space e$ 1],
  $P(x_0)$, [$and e_1$ 2],
  $forall x P(x)$, [$forall x space i$ 2-3],
  [+], 2,
  $x_0$, [x],
  $P(x_0) and Q(x_0)$, [$forall x space e$ 1],
  $Q(x_0)$, [$and e_1$ 5],
  $forall x Q(x)$, [$forall x space i$ 5-6],
  $forall x P(x) and forall x Q(x)$, [$and i$ 4,7]
)

#line(length: 100%)

(9) #proof(
  $not forall x not P(x)$, [p],
  [+], 8,
  $not exists x P(x)$, [a],
  [+], 5,
  $x_0$, [x],
  $$,[],
  [+], 3,
  $P(x_0)$, [a],
  $exists x P(x)$, [$exists x space i$ 4],
  $bot$, [$not e$ 5, 2],
  $not P(x_0)$, [$not space i$ 4-6],
  $forall x not P(x)$, [$forall x space i$ 3-7],
  $bot$, [$not e$ 8,1],
  $exists x P(x)$, [PBC 2-9],
)

#line(length: 100%)

(10) #proof(
  $forall x not P(x)$, [p],
  [+], 5,
  $exists x P(x)$, [a],
  [+], 3,
  $x_0$, [x],
  $P(x_0)$,[a],
  $not P(x_0)$, [$forall x space e$ 1],
  $bot$, [$not e$ 3,4],
  $bot$, [$exists e$ 2,3-5],
  $not exists x P(x)$, [$not i$ 2-6]
)