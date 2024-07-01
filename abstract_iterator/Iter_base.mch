MACHINE
    Iter_base
    
ABSTRACT_CONSTANTS
    
    Trains,
    is_MP85
    
CONCRETE_CONSTANTS
    
    First, Last
    
PROPERTIES
    
    First : NAT &
    Last : NAT &
    First <= Last &
    Last < MAXINT &
    Trains = First..Last &
    is_MP85 : Trains --> BOOL
    
OPERATIONS
    
    res <-- is_MP85_op (train) =
    PRE
        train : NAT &
        train : Trains
    THEN
        res := is_MP85 (train)
    END
    
END