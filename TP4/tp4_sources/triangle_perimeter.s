.globl _ZNK9CTriangle12PerimeterAsmEv

_ZNK9CTriangle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        movl 8(%ebp), %eax
        

        flds 4(%eax)
        flds 8(%eax)

        faddp 
        flds 12(%eax)
        faddp
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
