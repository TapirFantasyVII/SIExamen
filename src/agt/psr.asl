variable(1). variable(2). variable(3). variable(4).
variable(5). variable(6). variable(7). variable(8).

dom(1). dom(2). dom(3). dom(4).
dom(5). dom(6). dom(7). dom(8).

reinas(Asig) :- .findall(X, variable(X), Filas) & asigF([], Asig, Filas).

// caso base: el acumulador acabado ES la asignación final
asigF(Asig, Asig, []).
asigF(AccIn, AccOut, [Car|Cdr]) :-
    .findall(X, dom(X), Columnas) &
    asigC(AccIn, AccOut, [Car|Cdr], Columnas).

// prueba a colocar la fila FCar en la columna CCar
asigC(AccIn, AccOut, [FCar|FCdr], [CCar|_]) :-
    valida(FCar, CCar, AccIn) &
    asigF([reina(FCar, CCar)|AccIn], AccOut, FCdr).
// si no, prueba la siguiente columna (backtracking)
asigC(AccIn, AccOut, Filas, [_|CCdr]) :-
    asigC(AccIn, AccOut, Filas, CCdr).

valida(_, _, []).
valida(Fila, Columna, [reina(X,Y)|Cdr]) :-
    Fila \== X &
    Columna \== Y &
    math.abs(Fila - X) \== math.abs(Columna - Y) &
    valida(Fila, Columna, Cdr).

!start.
+!start : reinas(Asig) <- .print(Asig).