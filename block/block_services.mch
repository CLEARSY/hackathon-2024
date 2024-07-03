MACHINE
	block_services
DEFINITIONS
	d_free_b  == (t_block - ob) ;
	d_free_td == (t_block - otd) ;
	d_bd2b    == (cfg_b2bd_up \/ cfg_b2bd_down)~

SEES
	configuration,
	inputs
VARIABLES
	ob, tdla,mb
INVARIANT
	ob <: t_block &
	tdla <: t_block &
	mb <: t_block
INITIALISATION
	ob := t_block ||
	tdla := t_block ||
	mb := {}
OPERATIONS

	p_res <-- read_mb(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : mb)
	END;

	unmask_block(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		mb := mb - {p_block}
	END;

	mask_block(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		mb := mb \/ {p_block}
	END;

	p_res <-- read_tdla(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : tdla)
	END;

	alarm_block(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		tdla := tdla \/ {p_block}
	END;

	unalarm_block(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		tdla := tdla - {p_block}
	END;

	clear_tdla = BEGIN
		tdla := {}
	END;

	p_res <-- read_ob(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : ob)
	END;

	occ_block(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		ob := ob \/ {p_block}
	END;

	unocc_block(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		ob := ob - {p_block}
	END;

	p_res <-- cond_unmask(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : (d_free_b \/
			 (cfg_b2b_up~  [d_free_td \/ d_free_b] /\
			  cfg_b2b_down~[d_free_td \/ d_free_b])))
	END;

	p_res <-- cond_mask(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : d_bd2b[obd] - tdla)
	END;
	
	p_res <-- cond_alarm(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : (ob - mb - otd))
	END;

	p_res <-- cond_release(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : 
			    ((cc_init \/ (t_block - tdla)) /\
				 (cfg_b2ed_up \/ cfg_b2ed_down)~
				 [oed_prev - oed])
		)
	END;

	p_res <-- cond_occupy(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : (d_bd2b[obd] \/ otd))
	END

END
		