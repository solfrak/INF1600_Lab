.global q1_s
.global q2_s

q1_s:
    /* VOTRE PROGRAMME ASSEMBLEUR ICI ...  */
    
    flds e             
    flds d                            
    fmulp   
    flds b 
    fsubrp  
    fstps a
    flds g
    flds f
    faddp 
    flds a
    fdivp 
    flds f
    fsubrp
    fstps a
    flds b 
    flds c 
    faddp 
    flds d              
    fdivrp                   
    flds a
    fmulp
    fstps a
    ret

q2_s:
	/* VOTRE PROGRAMME ASSEMBLEUR ICI ...  */
    
    flds theta
    fcos    
    flds b 
    fmulp  
    flds a
    fmulp 
    fmul constant
    fstps c
    flds b
    flds b 
    fmulp
    flds c
    fsubrp 
    fstps c
    flds a
    flds a
    fmulp
    flds c
    faddp
    fsqrt 
    fstps c
    ret
