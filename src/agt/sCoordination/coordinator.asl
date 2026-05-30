trabajo([1,2,3,4]).

!start.


+!start : trabajo(L) <-
    .broadcast(tell ,  tell_preference(a));
    .broadcast(tell ,  tell_preference(b));
    .broadcast(tell ,  tell_preference(c));
    .broadcast(tell ,  tell_preference(d));
    .wait(500);
    !select_win(L).
    
+!select_win([Car|_]) : 

            preference(a, A) & .member(Car, A) &
            preference(b, B) & .member(Car, B) &
            preference(c, C) & .member(Car, C) &
            preference(d, D) & .member(Car, D) 
            <-
            .print("seleccionado ", Car).


+!select_win ([]) <- .print("no solucion").

+!select_win ([Car|Cdr]) :
            preference(a, A) & 
            preference(b, B) & 
            preference(c, C) &  
            preference(d, D)  
            <-  
            .print("no valido " , Car );
            !select_win(Cdr).


-!select_win(_) <- .print("algo ha fallado").
