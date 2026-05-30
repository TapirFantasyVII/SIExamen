light(light1, off).
light(light2, off).

switch_ok(light1, true).
switch_ok(light2, true).

switch_on(light1, false).
switch_on(light2, false).

attempts(light1, 0). 
attempts(light2, 0). 

distance(12, light1).
distance(5, light2).

+percept_light(L, on) <- -light(L, off); +light(L, on).
+percept_light(L, off) <- -light(L, on); +light(L, off).

!manage_lights.

+! manage_lights :
 .findall(par(N,X), light(X, off) & distance(N, X) , ToTurn ) &
 .sort(ToTurn, R) <-
    !turnAll(R).

+!turnAll([par(N,X)|Cdr]) <- !turn(X) ; !turnAll(Cdr).
+!turnAll([]) <- .print("todas las luces encendidas").

+!turn(X) <- .print("encendiendo luz 1 ");
            !goto(X);
            !turnSwitch(X);
            !checkLight(X).


+!goto(X) : distance(N, X) <- 
    .print("yendo a " , X);
    .wait(N*50);
    +at(X).

+!turnSwitch(X) : at(X) & switch_on(X, true) <- .print("switch ya encendido").
+!turnSwitch(X) : at(X) <-
    //switch(X)
    -switch_on(X, false);
    .wait(100);
    +switch_on(X, true);
    ?random_fail(F);
    if(F = ok){
        
        -light(X, off);
        +light(X, on);
    }else{
        .print("fallo interruptor");
        !recove(X);
    }.

+?random_fail(F) <- .random(R); if (R < 0.33) { F = fail; } else { F = ok; }.
 
+!recove(X) :attempts(X, 3) <-
    -switch_ok(X, true);
    +switch_ok(X, false);
    !!repair(X).
+!recove(X) :attempts(X,Y) <-
    .print("reintentando...");
     -attempts(X,Y);
     +attempts(X,Y+1);
     .wait(100);
     -switch_on(X, true);
     +switch_on(X, false);
     !turnSwitch(X).

+! repair(X) <-
    .print("reparando switch de ", X);
    .wait(15000);
    -switch_ok(X, false);
    +switch_ok(X, true).

+!checkLight(X) :light(X, on)<- .print("luz encendida con exito").
+!checkLight(X) :light(X, off)<- .print("luz no encendida").