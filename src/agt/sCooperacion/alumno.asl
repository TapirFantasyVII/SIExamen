trabajo(1).
trabajo(2).
trabajo(3).
trabajo(4).


intersectar([], _ , []).
intersectar([Car|Cdr], L , [Car|Res]) :- .member(Car,L) & intersectar(Cdr, L, Res).
intersectar([_|Cdr], L , Res) :-   intersectar(Cdr, L, Res).
 
 

!start.
//primero en hablar
+!start   <-
    !identify; 
    .wait(100);
    !tell_preferences.
 


+!identify : me(X) & .my_name(N) <- .broadcast(tell, other(X, N)).

+!tell_preferences : me(1) & other(2, N) 
<-
    .findall(P, preference(P), L);
    .print("mis preferencias son ", L);
    .send(N ,tell , preference(1, L)).

+!tell_preferences : me(X) & other(X+1,N) &
                preference(X-1, OthersPreferences)  &
                .findall(P, preference(P), MyPreference) &
                intersectar(OthersPreferences , MyPreference , R)
               <-
                .print("mis preferencias intesectadas ", R);
                .send(N ,tell , preference(X, R)).

+!tell_preferences : me(X) & preference(X-1, OthersPreferences)  &
                    .findall(P, preference(P), MyPreference) &
                    intersectar(OthersPreferences , MyPreference , R)
            <- 
           .print("validas " , R).
               


+!tell_preferences <- .print("no me toca...").
-!tell_preferences <- .print("falle").  

+preference(_,_)  <- !tell_preferences.

