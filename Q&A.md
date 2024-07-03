Question: A block having one of its border detector occupied or having its trackside detector occupied *has* to be occupied.
Is this condition is sufficient _and_ necessary for a block to be occupied, or just sufficient, i.e. whether
    d_b2b[obd] \/ otd <: ob                            (sufficient only)
or
    d_b2b[obd] \/ otd = ob                    (sufficient and necessary)

Answer: It is sufficient only. You should read it as an implication, not an equivalence.

Question: Is the abstract machine statement (unmask_blocks) should look something like below ?

    mb := mb - (d_free_b                               // The block is free
                \/                                     // *or*
                (cfg_b2b_up[d_free_td \/ d_free_b]     // 1)
                 /\                                    // and
                 cfg_b2b_down[d_free_td \/ d_free_b])) // 2)

Answer: It is almost correct but incorrect. With cfg_b2b_up[d_free_td \/ d_free_b], you are referring to the upward block but what we need to consider here is the block which has this upward block. It applies to cfg_b2b_down[d_free_td \/ d_free_b] as well. You should use cfg_b2b_up~[...].

Question: I've specified `mask_blocks' as
    mb := mb \/ (d_bd2b[obd] - tdla)
but the automatic prover is not able to assert that this is indeed a set of `t_block'.

Answer: Use User Pass Proof (Ctrl+U).
If you don't have the corresponding Pmm file, the proof script that demonstrates the proof obligation is: dd(0) & mp & pp(rt.1 | 5).