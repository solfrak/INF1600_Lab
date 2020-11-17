.data
        factor: .float 2.0 /* use this to divide by two */

.text
.globl _ZNK9CTriangle7AreaAsmEv

_ZNK9CTriangle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
         
        movl 8(%ebp), %eax      # classe dans eax
        
        pushl %eax              # eax sur la pile:
        movl (%eax), %eax       # mettre la v table dans %eax
        call *12(%eax)          # call triangle perimetre
        add $4, %esp            # retour au dessus de la pile

        flds factor
        fdivp           # st0: p
        fstp -8(%ebp)

        flds -8(%ebp)
        flds 4(%eax)    # st1: p  st0 m0
        fsubp           # res dans st0, st1 libéré
        fstp -12(%ebp)   #p-m0

        flds -8(%ebp)
        flds 8(%eax)    ###
        fsubp
        fstp -16(%ebp)  #p m1 

        flds -8(%ebp)
        flds 12(%eax)   #p m2
        fsubp          # res dans st0
        
        flds -8(%ebp)   #p m1
        fmulp           # res dans st0

        flds -12(%ebp) #p-m0
        fmulp          # res dans st0

        flds -16(%ebp)   #p
        fmulp           #mul par p

        fsqrt

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
