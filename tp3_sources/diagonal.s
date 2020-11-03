.global matrix_diagonal_asm

matrix_diagonal_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */
        
        /* Programme ici */
		
        leave          			/* Restore ebp and esp */
        ret            			/* Return to the caller */

