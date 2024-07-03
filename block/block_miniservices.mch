MACHINE
	block_miniservices
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

	p_res <-- is_free_block(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : d_free_b)
	END;
	
	p_res <-- has_up_free_or_freetd(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : cfg_b2b_up~[d_free_td \/ d_free_b])
	END;

	p_res <-- has_down_free_or_freetd(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : cfg_b2b_down~[d_free_td \/ d_free_b])
	END;

	p_res <-- has_occupied_bd(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : d_bd2b[obd])
	END;

	p_res <-- is_occ_unmasked_block(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : ob - mb)
	END;

	p_res <-- is_init_or_unalarmed_block(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : (cc_init \/ (t_block - tdla)))
	END;

	p_res <-- has_up_tr_ed(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : cfg_b2ed_up~[oed_prev - oed])
	END;

	p_res <-- has_down_tr_ed(p_block) = PRE
		p_block : t_block_i &
		p_block : t_block
	THEN
		p_res := bool(p_block : cfg_b2ed_down~[oed_prev - oed])
	END

END
