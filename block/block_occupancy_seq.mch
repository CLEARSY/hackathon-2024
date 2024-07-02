	/***************************************************************************
	  Module Name:
	  block_occupancy_seq
	  
	  Description:
	  Management of block occupancy at sequencing level
	  
	  *************************************************************************/
MACHINE
	block_occupancy_seq

SEES
	configuration,
	inputs
	

DEFINITIONS
	
	/* The set of free blocks (non-occupied blocks) */
	d_free_b              == (t_block - ob) ;
	
	/* The set of free border detectors (non-occupied border detectors) */
	d_free_bd    == (t_border - obd) ;
	
	/* The set of free trackside detectors (non-occupied trackside detectors) */
	d_free_td == (t_block - otd) ;

	/* Relation beetween a border and a block located at one end of the block
	   (warning: this relation is not a function since one border is related
	   to 2 blocks) */
	d_b2b == (cfg_b2bd_up \/ cfg_b2bd_down)~

	
ABSTRACT_VARIABLES
	
	ob,
	tdla

	
INVARIANT
	
	ob        <: t_block &
	tdla <: t_block

	
INITIALISATION
	
	ob,
	tdla
	:(ob        <: t_block &
	  tdla <: t_block
	  )

	
OPERATIONS

	set_block_occupancy =
	/***************************************************************************
	  Operation Name :
	  set_block_occupancy
	  
	  Input parameters:
	  none
	  
	  Output parameters:
	  none
	  
	  Functionality:
	  This function manages block occupancy, by calling operations in the
	  following order:
	  - unmask_blocks
	  - release_tdl_alarm
	  - set_tdl_alarm
	  - mask_blocks
	  - release_blocks
	  - occupy_blocks

	  Properties:
	  - Property 1:
	  A block having one of its border detector occupied or having its trackside
	  detector occupied has to be occupied.
	  *************************************************************************/
	BEGIN
		ob,
		tdla
		:(ob        <: t_block &
		  tdla <: t_block 

		  /* TO COMPLETE: Property 1 */

		  )
	END

END

	
