trabajo(1).
trabajo(2).
trabajo(3).
trabajo(4).

 

!start.

+!start : preference(N) & me(X) <-
    .wait(X *100) ;
    !seleccionar.

+!seleccionar : not selccionado(_) & preference(X) <-
    .broadcast(tell, selccionado(X));
    .print("seleccionado " , X).

+!seleccionar :  selccionado(X)  <- 
    .print("seleccionado " , X).
    
