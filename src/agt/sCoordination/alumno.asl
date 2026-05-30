trabajo(1).
trabajo(2).
trabajo(3).
trabajo(4).

 
 
+tell_preference(X) : me(X) <-
    .findall(P, preference(P), L);
    .send(coordinator ,tell , preference(X, L)).
    
+tell_preference <- .print("no es yo").