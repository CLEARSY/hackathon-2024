	/***************************************************************************
	  Module Name:
	  configuration
	  
	  Description:
	  Types and configuration data describing the system.

	  *************************************************************************/
	
	/***************************************************************************
	  **************************************************************************
	  EXPLANATION ON TYPES AND CONFIGURATION DATA
	  
	  Types and configuration data are represented by 'SETS' and
	  constants data.  For example we describe the line with a type
	  for blocks that includes all the actual blocks of the line, and two
	  configuration data that give for a certain block its next upward
	  block and its next downward block.  The values of those
	  constants are not part of the B model. Only their general
	  properties are written in B. Their values depend on the actual
	  caracteristics of the line. They are written directly in the
	  target programming language, so in case of configuration
	  modification or reuse for another line, the part of the software
	  translated from B remains unchanged.

	  Unfortunately, since the constants are valued outside the B
	  model, we are not sure that their values comply with their
	  properties. So another validation process needs to be used
	  (hopefully using automatic tools to save time).
	  
	  *************************************************************************
	  *************************************************************************/

MACHINE
	configuration

SETS

	/***************************************************************************
	  **************************************************************************
	  EXPLANATION ON SETS

	  The 'SETS' clause is used to define non-empty, finite, implementable sets
	  regarded as incompatible types. In this case, as blocks and borders are 2
	  different types, a block cannot be used where a border is expected. The
	  error would be automatically detected through Type Checking.
	  
	  In this model, to define a type for blocks, we declare:
	  - A 'SETS' named t_block_i, where 'i' stands for implementation.
	  - A constant subset named t_block that represents the set of all actual
	  blocks. At specification level only this set is used.
	  - A scalar constant named c_block_undet that belongs to t_block_i, but
	  that does not belong to t_block. This constant represents an undetermined
	  block. It is only used at implementation level.

	  *************************************************************************
	  ************************************************************************/
	
	t_block_i;
	t_border_i;
	t_exit_i

	
CONCRETE_CONSTANTS

	t_block,
	c_block_undet,
	/***************************************************************************
	  Constant Name: t_block
	  
	  Typing: t_block <: t_block_i
	  
	  Description: Set of all blocks of the line

	  *************************************************************************/

	t_border,
	c_border_undet,
	/***************************************************************************
	  Constant Name: t_border
	  
	  Typing: t_border <: t_border_i
	  
	  Description: Set of all borders of the line

	  *************************************************************************/

	t_exit,
	c_exit_undet
	/***************************************************************************
	  Constant Name: t_exit
	  
	  Typing: t_exit <: t_exit_i
	  
	  Description: Set of all exit detectors of the line

	  *************************************************************************/


ABSTRACT_CONSTANTS

	cfg_b2b_up,
	/***************************************************************************
	  Constant Name: cfg_b2b_up
	  
	  Typing: cfg_b2b_up : t_block +-> t_block
	  
	  Description:
	  Function giving for a block the next upward block. An upward terminal
	  block does not have any next upward block.
	  *************************************************************************/

	cfg_b2b_down,
	/***************************************************************************
	  Constant Name: cfg_b2b_down
	  
	  Typing: cfg_b2b_down : t_block +-> t_block
	  
	  Description:
	  Function giving for a block the next downward block. A downward terminal
	  block does not have any next downward block.
	  *************************************************************************/

	cfg_b2bd_up,
	/***************************************************************************
	  Constant Name: cfg_b2bd_up
	  
	  Typing: cfg_b2bd_up : t_block +-> t_border
	  
	  Description:
	  Function giving for a block its upward border. An upward terminal
	  block does not have any upward border.
	  *************************************************************************/

	cfg_b2bd_down,
	/***************************************************************************
	  Constant Name: cfg_b2bd_down
	  
	  Typing: cfg_b2bd_down : t_block +-> t_border
	  
	  Description:
	  Function giving for a block its downward border. A downward terminal
	  block does not have any downward border.
	  *************************************************************************/

	cfg_b2ed_up,
	/***************************************************************************
	  Constant Name: cfg_b2ed_up
	  
	  Typing: cfg_b2ed_up : t_block +-> t_exit
	  
	  Description:
	  Function giving for a block its upward exit detector. An upward terminal
	  block does not have any upward exit detector.
	  *************************************************************************/

	cfg_b2ed_down,
	/***************************************************************************
	  Constant Name: cfg_b2ed_down
	  
	  Typing: cfg_b2ed_down : t_block +-> t_exit
	  
	  Description:
	  Function giving for a block its downward exit detector. A downward
	  terminal block does not have any downward exit detector.
	  *************************************************************************/
    bijection_t_block

PROPERTIES
	
	t_block        <: t_block_i  &
	c_block_undet   : t_block_i  &
	c_block_undet  /: t_block    &
	
	t_border       <: t_border_i &
	c_border_undet  : t_border_i & 
	c_border_undet /: t_border   &
	
	t_exit         <: t_exit_i   &
	c_exit_undet    : t_exit_i   &
	c_exit_undet   /: t_exit     &

	cfg_b2b_up      : t_block +-> t_block  &
	cfg_b2b_down    : t_block +-> t_block  &
	cfg_b2bd_up     : t_block +-> t_border &
	cfg_b2bd_down   : t_block +-> t_border &
	cfg_b2ed_up     : t_block +-> t_exit   &
	cfg_b2ed_down   : t_block +-> t_exit &

    bijection_t_block  : NAT +-> t_block_i &
    bijection_t_block  : perm(t_block) &
    card(t_block) = size(bijection_t_block) &
    card(t_block) <= MAXINT
    
OPERATIONS
    
    ee <-- read_bijection_t_block ( rg ) =
    PRE
        rg : NAT &
        rg : dom(bijection_t_block)
    THEN
        ee := bijection_t_block(rg)
    END;
    
    ee <-- read_card_t_block = 
    BEGIN
        ee := card(t_block)
    END;
    p_belongs, p_up <-- read_all_cfg_b2b_up(p_block) =
    PRE
        p_block : t_block_i &
        p_block : t_block
    THEN
        p_belongs := bool(p_block : dom(cfg_b2b_up)) ||
        IF p_block : dom(cfg_b2b_up)
        THEN
            p_up := cfg_b2b_up(p_block)
        ELSE
            p_up :: t_block_i
        END
    END;
    
    p_belongs, p_down <-- read_all_cfg_b2b_down(p_block) =
    PRE
        p_block : t_block_i &
        p_block : t_block
    THEN
        p_belongs := bool(p_block : dom(cfg_b2b_down)) ||
        IF p_block : dom(cfg_b2b_down)
        THEN
            p_down := cfg_b2b_down(p_block)
        ELSE
            p_down :: t_block_i
        END
    END;
    
    p_belongs, p_up <-- read_all_cfg_b2bd_up(p_block) =
    PRE
        p_block : t_block_i &
        p_block : t_block
    THEN
        p_belongs := bool(p_block : dom(cfg_b2bd_up)) ||
        IF p_block : dom(cfg_b2bd_up)
        THEN
            p_up := cfg_b2bd_up(p_block)
        ELSE
            p_up :: t_border_i
        END
    END;
    
    p_belongs, p_down <-- read_all_cfg_b2bd_down(p_block) =
    PRE
        p_block : t_block_i &
        p_block : t_block
    THEN
        p_belongs := bool(p_block : dom(cfg_b2bd_down)) ||
        IF p_block : dom(cfg_b2bd_down)
        THEN
            p_down := cfg_b2bd_down(p_block)
        ELSE
            p_down :: t_border_i
        END
    END;
    
    p_belongs, p_up <-- read_all_cfg_b2ed_up(p_block) =
    PRE
        p_block : t_block_i &
        p_block : t_block
    THEN
        p_belongs := bool(p_block : dom(cfg_b2ed_up)) ||
        IF p_block : dom(cfg_b2ed_up)
        THEN
            p_up := cfg_b2ed_up(p_block)
        ELSE
            p_up :: t_exit_i
        END
    END;
    
    p_belongs, p_down <-- read_all_cfg_b2ed_down(p_block) =
    PRE
        p_block : t_block_i &
        p_block : t_block
    THEN
        p_belongs := bool(p_block : dom(cfg_b2ed_down)) ||
        IF p_block : dom(cfg_b2ed_down)
        THEN
            p_down := cfg_b2ed_down(p_block)
        ELSE
            p_down :: t_exit_i
        END
    END	
END


	
