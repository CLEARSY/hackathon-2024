MACHINE
    Iter_services
SEES
    Iter_base
    
ABSTRACT_VARIABLES
    
    Todo,
    Done
    
INVARIANT
    
    Todo <: Trains &
    Done <: Trains &
    Todo \/ Done = Trains &
    Todo /\ Done = {}
    
INITIALISATION
    
    Todo := Trains ||
    Done := {}
    
OPERATIONS
    
    continue <-- init_iter =
    BEGIN
        Todo := Trains ||
        Done := {} ||
        continue := bool (Trains /= {})
    END
    ;
    
    continue, elt <-- next_iter =
    PRE
        Todo /= {}
    THEN
        ANY
            chosen,
            new_Todo
        WHERE
            chosen : NAT &
            chosen : Todo &
            new_Todo = Todo - {chosen}
        THEN
            Todo := new_Todo ||
            Done := Done \/ {chosen} ||
            continue := bool (new_Todo /= {}) ||
            elt := chosen
        END
    END

END
