// Agent bob in project examen

/* Initial beliefs and rules */

/* Initial goals */

capacidad_mochila(40).
mochila([]).
llenado(0).

obj(1, 10).
obj(2, 15).
obj(3, 37).
obj(4, 2).
obj(5, 5).
 
mejor([Obj], Obj).
mejor([obj(X,V)|Cdr], obj(X,V))   :- mejor(Cdr, obj(_,V2)) & V >= V2.
mejor([obj(X,V)|Cdr], MejorResto) :- mejor(Cdr, MejorResto) &
                                     MejorResto = obj(_,V2) & V < V2.


!start.


/* Plans */

+!start : true <- !llenar.

+!llenar : mochila (Objs) &
    capacidad_mochila(Capacidad) &
    llenado(Llenado) &
    .findall(obj(X,Y), obj(X, Y) &
             Y <= Capacidad -Llenado &
             not .member( obj(X, Y) , Objs) 
             , Posibles)  &
    mejor(Posibles , Mejor)
    <-
    .print("seleccionado ", Mejor);
    -mochila(Objs);
    +mochila([Mejor|Objs]);
    !actualizar_Cap(Mejor);
    !llenar.
 +!llenar : mochila (Objs) 
 <-
    .print("mochila llena: ",Objs ).

+!actualizar_Cap(obj(T, Cap)) : llenado(X)<-
    New = X+Cap;
    -llenado(X);
    +llenado(New);
    .print("capAct " , X+Cap).