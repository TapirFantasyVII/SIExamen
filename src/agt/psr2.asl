regiones([a,b,c,d,e]).
colores([1,2,3]).

// aristas del grafo (dirigidas tal cual las diste)
vecino(a,b). vecino(a,c). vecino(b,c). vecino(b,d). vecino(c,d). vecino(d,e).

// vecindad simétrica: da igual el orden en que se declaró la arista
sonVecinos(X,Y) :- vecino(X,Y).
sonVecinos(X,Y) :- vecino(Y,X).

// ---- punto de entrada ----
// arranca con acumulador vacío y devuelve el mapa coloreado en MapaF
asignarColores(MapaF) :- regiones(Rs) & asigR([], MapaF, Rs).

// caso base: cuando no quedan regiones, el acumulador ES la solución
asigR(Mapa, Mapa, []).
asigR(AccIn, AccOut, [Region|Resto]) :-
    colores(Colores) &
    elegir(AccIn, AccOut, Region, Resto, Colores).

// prueba el primer color de la lista para Region
elegir(AccIn, AccOut, Region, Resto, [Color|_]) :-
    valida(Region, Color, AccIn) &
    asigR([par(Region,Color)|AccIn], AccOut, Resto).
// si no vale (o falla más adelante), backtrack: prueba el siguiente color
elegir(AccIn, AccOut, Region, Resto, [_|OtrosColores]) :-
    elegir(AccIn, AccOut, Region, Resto, OtrosColores).

// ---- restricción ----
// Color es válido para Region si ninguna vecina ya coloreada tiene ese color
valida(_, _, []).
valida(Region, Color, [par(R2,_)|Resto]) :-
    not sonVecinos(Region, R2) &        // no es vecina -> no restringe
    valida(Region, Color, Resto).
valida(Region, Color, [par(R2,C2)|Resto]) :-
    sonVecinos(Region, R2) &            // es vecina -> debe diferir
    Color \== C2 &
    valida(Region, Color, Resto).

// ---- objetivo inicial ----
!start.
+!start : asignarColores(Mapa) <- .print("Mapa: ", Mapa).