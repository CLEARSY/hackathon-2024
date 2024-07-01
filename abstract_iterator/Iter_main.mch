MACHINE
    Iter_main
SEES
    Iter_base
    
OPERATIONS
    
    res <-- nb_MP85 = res := card (is_MP85~[{TRUE}] /\ Trains)
    ;

    res <-- all_MP85 = res := bool (is_MP85~[{TRUE}] = Trains)

END
