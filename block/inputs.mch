	/***************************************************************************
	  Module Name:
	  inputs
	  
	  Description:
	  Management of input messages
	  - 1 message from trackside equipements (trackside detectors, border
	  detectors, exit detectors)
	  - 1 message from the Control Center (initialized blocks, TDC alarm
	  acknowledgement)
	  
	  *************************************************************************/
MACHINE
	inputs

SEES
	configuration

	
ABSTRACT_VARIABLES
	
	otd,
	/***************************************************************************
	  Variable Name: otd
	  
	  Typing: otd <: t_block
	  
	  Description: Set of blocks having an occupied trackside detector

	  Initialization: otd := t_block

	  *************************************************************************/

	obd,
	/***************************************************************************
	  Variable Name: obd
	  
	  Typing: obd <: t_border
	  
	  Description: Set of occupied trackside detector

	  Initialization: obd := t_border

	  *************************************************************************/

	oed,
	/***************************************************************************
	  Variable Name: oed
	  
	  Typing: oed <: t_exit
	  
	  Description: Set of occupied exit detector

	  Initialization: oed := t_exit

	  *************************************************************************/

	oed_prev,
	/***************************************************************************
	  Variable Name: oed_prev
	  
	  Typing: oed_prev <: t_exit
	  
	  Description: Set of occupied exit detector during the previous run cycle

	  Initialization: oed_prev := t_exit

	  *************************************************************************/

	cc_init,
	/***************************************************************************
	  Variable Name: cc_init
	  
	  Typing: cc_init <: t_block
	  
	  Description: Set of blocks beeing initialized by the Control Center

	  Initialization: cc_init := {}

	  *************************************************************************/
	
	cc_tdl_ack
	/***************************************************************************
	  Variable Name: cc_tdl_ack
	  
	  Typing: cc_tdl_ack : BOOL
	  
	  Description: Acknowledgement of TDL alarm for all blocks, send by the
	  Control Center

	  Initialization: cc_tdl_ack := FALSE

	  *************************************************************************/
	
INVARIANT
	
	otd       <: t_block  &
	obd       <: t_border &
	oed       <: t_exit   &
	oed_prev  <: t_exit   &
	cc_init   <: t_block  &
	cc_tdl_ack : BOOL
	
INITIALISATION

	otd        := t_block  ||
	obd        := t_border ||
	oed        := t_exit   ||
	oed_prev   := t_exit   ||
	cc_init    := {}       ||
	cc_tdl_ack := FALSE

	
OPERATIONS
	
	read_inputs =
	/***************************************************************************
	  Operation Name: read_inputs

	  Input parameters: none

	  Output parameters: none

	  Functionality:
	  This function reads the inputs messages.
	  *************************************************************************/
	BEGIN
		otd,
		obd,
		oed,
		cc_init,
		cc_tdl_ack
		:(otd       <: t_block  &
		  obd       <: t_border &
		  oed       <: t_exit   &
		  cc_init   <: t_block  &
		  cc_tdl_ack : BOOL
		  )
	END
	;
	
	save_inputs_prev =
	/***************************************************************************
	  Operation Name: save_inputs_prev

	  Input parameters: none

	  Output parameters: none

	  Functionality:
	  This function saves the actual value of occupied exit detectors for the
	  next execute cycle.
	  *************************************************************************/
	BEGIN
		oed_prev := oed
	END
	

END

