.global matrix_row_aver_asm

matrix_row_aver_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */
        
		/* Programme ici */
		
        leave          			/* Restore ebp and esp */
        ret           			/* Return to the caller */
		
