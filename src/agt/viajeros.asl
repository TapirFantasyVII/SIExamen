
nodo(a).
nodo(b).
nodo(c).
nodo(d).
nodo(e).
nodo(f).
nodo(g).

conexion(a,b).
conexion(b, g). 
conexion(g, t).
conexion(t, g).
conexion(t, c).
conexion(c, d).
conexion(d, e).
conexion(e, f).


llegar(N, N, _, [N]) :- .print("llegado").
llegar(NodoA, NodoB, Vis, [NodoA|L]) :-
    .findall(D, conexion(NodoA, D) & not .member(D, Vis), Posibles) &
    intentar(Posibles, NodoB, Vis, L).


intentar([Car|_],  NodoB, Vis, L) :- llegar(Car, NodoB, [Car|Vis], L).
intentar([_|Cdr],  NodoB, Vis, L) :- intentar(Cdr, NodoB, Vis, L).

!start.
+!start : llegar(a, f, [a], L) <- .print("camino: ", L).
+!start : true <- .print("no se puede llegar").