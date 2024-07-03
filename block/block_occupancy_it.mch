MACHINE
	 block_occupancy_it

SEES
	 configuration
	 
VARIABLES
	 block_to_treat,
	 treated_block

INVARIANT
	 block_to_treat <: t_block &
	 treated_block <: t_block &
	 block_to_treat /\ treated_block = {} &
	 block_to_treat \/ treated_block = t_block

INITIALISATION
	 block_to_treat := t_block ||
	 treated_block := {}

OPERATIONS

	 cond <-- init_iteration_t_block =
	 BEGIN
		  block_to_treat := t_block ||
		  treated_block := {} ||
		  cond := bool(t_block /= {})
	 END;
	 
	 cond, bl <-- iterate_t_block =
	 PRE
		  block_to_treat /= {}
	 THEN
		  ANY
				n_bl
		  WHERE
				n_bl : t_block_i &
				n_bl : t_block &
				n_bl : block_to_treat
		  THEN
				bl := n_bl ||
				block_to_treat := block_to_treat - {n_bl} ||
				treated_block := treated_block \/ {n_bl} ||
				cond := bool(block_to_treat /= {n_bl})
		  END
	 END

END	 
	 
