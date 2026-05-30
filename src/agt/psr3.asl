agt([bob, alice]).
tarea([1,2,3,4]).

precede(3,4).
precede(1,2).

no(bob,3).
no(alice,1).

// In = plan ya construido (acumulador); Out = plan final
asignarTarea(Out) :- tarea(Tareas) & work(Out, [], Tareas).

// caso base: sin tareas pendientes, el acumulado es la solución
work(Hecho, Hecho, []).
work(Out, Hecho, Pendientes) :-
    .member(T, Pendientes) &            // elige una tarea pendiente
    precedenciasOk(T, Hecho) &          // sus predecesoras YA están hechas
    agt(Agentes) & .member(A, Agentes) &
    not no(A, T) &                      // ese agente puede hacerla
    .delete(T, Pendientes, Resto) &     // quítala de pendientes
    work(Out, [par(A,T)|Hecho], Resto).

// todas las X con precede(X,T) deben estar en Hecho
precedenciasOk(T, Hecho) :-
    .findall(X, precede(X,T), Pre) &
    todasHechas(Pre, Hecho).

todasHechas([], _).
todasHechas([X|Xs], Hecho) :- yaHecha(X, Hecho) & todasHechas(Xs, Hecho).

yaHecha(X, [par(_,X)|_]).
yaHecha(X, [_|Resto]) :- yaHecha(X, Resto).

!start.
+!start : asignarTarea(Out) <- .reverse(Out, Plan) & .print("Plan: ", Plan).