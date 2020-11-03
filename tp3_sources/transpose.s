.globl matrix_transpose_asm

matrix_transpose_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        pushl %ebx
        pushl %esi

		/* Programme ici */

        movl $0, %esi   # r
        movl $0, %edi   # c
        LOOP1:
            addl $1, %esi
            movl $0, %edi
        LOOP2:
            addl $1, %edi
            
            movl 8(%ebp), %ecx  # inmatdata
            movl 12(%ebp), %edx  # outmatdata
            movl 16(%ebp), %ebx  # matorder

            # c+r*matorder dans %eax
            movl %esi, %eax
            imul %ebx, %eax
            addl %edi, %eax
            # met la valeur inmatdata[c+r*matorder] dans %ecx
            movl (%ecx, %eax, 4), %ecx

            # r+c*matorder dans %eax
            movl %edi, %eax
            imul %ebx, %eax
            addl %esi, %eax
            # met la valeur %ecx dans outmatdata[r+c*matorder]
            movl %ecx, (%edx, %eax, 4)
        
        LOOP2END:
            cmp %esi, %ebx
            je LOOP1END
            jmp LOOP2
        LOOP1END:
            cmp %esi, %ebx
            je LOOP1
            jmp END
        END:
            popl %esi
            popl %ebx
            leave          /* restore ebp and esp */
            ret            /* return to the caller */
