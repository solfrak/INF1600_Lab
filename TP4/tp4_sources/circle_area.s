.globl _ZNK7CCircle7AreaAsmEv

_ZNK7CCircle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */

        mov 8(%ebp), %eax

        flds 4(%eax)
        flds 4(%eax)
        
        fmulp

        fldpi
        fmulp

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
