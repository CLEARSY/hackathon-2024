	/***************************************************************************
	  Module Name:
	  block_occupancy
	  
	  Description:
	  Management of block occupancy and Trackside Detector Loss (TDL) alarm
	  
	  *************************************************************************/
MACHINE
	block_occupancy
	
SEES
	configuration,
	inputs
	
DEFINITIONS

	/***************************************************************************
	  **************************************************************************
	  TIP: HOW TO USE DEFINITION
	  
	   The following definitions are given to help writing and reading the
	   B model.
	   When a definition name (the part before '==') appears in the model, it is
	   replaced by its value (the part between the '==' and the final ';')
	   before Type Check/Proof/Translation.
	   
	   In this model, definitions are suffixed by 'd_', so that they may be
	   easily identified.
	   
	   *************************************************************************
	   ************************************************************************/
	
	/* The set of free blocks (non-occupied blocks) */
	d_free_b  == (t_block - ob) ;
	
	/* The set of free trackside detectors (non-occupied trackside detectors) */
	d_free_td == (t_block - otd) ;

	/* Relation beetween a border and a block located at one end of the block
	   (warning: this relation is not a function since one border is related
	   to 2 blocks) */
	d_bd2b    == (cfg_b2bd_up \/ cfg_b2bd_down)~

	
ABSTRACT_VARIABLES
	
	ob,
	/***************************************************************************
	  Variable Name: ob
	  
	  Typing: ob <: t_block
	  
	  Description: Set of blocks considered as occupied

	  Initialization: ob := t_block

	  *************************************************************************/

	mb,
	/***************************************************************************
	  Variable Name: mb
	  
	  Typing: mb <: t_block
	  
	  Description: Set of masked blocks for TDL alarm

	  Initialization: mb := {}

	  *************************************************************************/
	
	tdla
	/***************************************************************************
	  Variable Name: tdla
	  
	  Typing: tdla <: t_block
	  
	  Description: Set of blocks in Trackside Detector Loss (TDL) alarm

	  Initialization: tdla := t_block

	  *************************************************************************/

	
INVARIANT

	ob   <: t_block &
	mb   <: t_block &
	tdla <: t_block

	
INITIALISATION
	
	ob   := t_block ||
	mb   := {}      ||
	tdla := t_block

	
OPERATIONS
 
	unmask_blocks =
	/***************************************************************************
	  Operation Name: mask_blocks
	  
	  Input parameters: none
	  
	  Output parameters: none
	  
	  Functionality:
	  This function unmasks some blocks (for TDL alarm). Blocks which do not
	  become unmasked remain unchanged.
	  A block is unmasked when the block is free or when all of the following
	  conditions are true:
	  1) The upward block has a free trackside detector or the upward block
	  is free.
	  2) The downward block has a free trackside detector or the downward block
	  is free.
	  *************************************************************************/
	BEGIN
		skip
		/* TO COMPLETE: mb := ... */
	END
	;
	
	release_tdl_alarm =
	/***************************************************************************
	  Operation Name: release_tdl_alarm
	  
	  Input parameters: none
	  
	  Output parameters: none
	  
	  Functionality :
	  This function releases Trackside Detector Loss (TDL) alarm.
	  When a TDL alarm acknowledgment is received from the Control Center,
	  then TDL alarm is released for all blocks.
	  If no TDL alarm acknowledgment is received then TDL alarm remains
	  unchanged.
	  *************************************************************************/
	BEGIN
	    skip
	/* TO COMPLETE: update tdla */

	END
	;

	set_tdl_alarm =
	/***************************************************************************
	  Operation Name: set_tdl_alarm
	  
	  Input parameters: none
	  
	  Output parameters: none
	  
	  Functionality :
	  This function sets Trackside Detector Loss (TDL) alarm. When a block does
	  not become in TDL alarm, then the alarm remains unchanged.
	  A block becomes in TDL alarm, when the following conditions are true:
	  1) The block is occupied.
	  2) The block is not masked.
	  3) The block trackside detector is free.
	  *************************************************************************/
	BEGIN
		skip 
		/* TO COMPLETE: tdla := ... */
	END
	;

	mask_blocks =
	/***************************************************************************
	  Operation Name: mask_blocks
	  
	  Input parameters: none
	  
	  Output parameters: none
	  
	  Functionality:
	  This function mask some blocks (for TDL alarm).
	  A block is masked when the folowing conditions are true:
	  1) The block is not in TDL alarm.
	  2) One of the block borders is occupied.
	  Blocks which do not become unmasked remain unchanged.
	  *************************************************************************/
	BEGIN
		skip
		/* TO COMPLETE: mb := ... */
	END
	;
	
	release_blocks =
	/***************************************************************************
	  Operation Name: release_blocks
	  
	  Input parameters: none
	  
	  Output parameters: none
	  
	  Functionality:
	  This function manages released blocks. Blocks which are not released
	  remain unchanged.
	  A block is consider to be released when the following conditions are true:
	  1) The block is not in TDL alarm or the block is beeing initialized by the
	  Control Center.
	  2) A block exit detector, which was occupied during the previous cycle, is
	  now released.
	  ************************************************************************/
	BEGIN
		skip
		/* TO COMPLETE: ob := ... */
	END
	;
	
	occupy_blocks =
	/***************************************************************************
	  Operation Name: occupy_blocks

	  Input parameters: none

	  Output parameters: none

	  Functionality:
	  This function manages occupied blocks. Blocks which do not become occupied
	  remain unchanged.
	  A block is consider to be occupied when one of its border detector is
	  occupied or when its trackside detector is occupied.
	  ************************************************************************/
	BEGIN
		skip
		/* TO COMPLETE: ob := ... */
	END
	
END

