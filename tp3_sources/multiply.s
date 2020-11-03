.globl matrix_multiply_asm

matrix_multiply_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
		
		/* Programme ici */
		
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
