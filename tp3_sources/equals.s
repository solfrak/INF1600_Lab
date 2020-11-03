
.globl matrix_equals_asm

matrix_equals_asm:
        /* Programme ici */
        .data
        maColonne:  .int 0
        maRange: .int 0
        data1: .int 0
        data2: .int 0
        matOrder: .int 0
        .text

        push %ebp      /* Save old base pointer */
        mov %esp, %ebp /* Set ebp to current esp */
        pushl %edi
        LOOP1:
                movl $0, maColonne
                jmp LOOP2
        LOOP2:

                
                # Assignation Registre
                movl 8(%ebp), %edx      # inmatdata1
                movl 12(%ebp), %edi     # inmatdata2
                movl 16(%ebp), %eax     # matorder
                movl %eax, matOrder

                # Calculquitr
                
                mov maRange, %ecx      # maRange dans %ecx
                imul %eax, %ecx         # maRange * matOrder dans %ecx
                addl maColonne, %ecx    # maColonne + %ecx 

                # inmatdata[c+r*matorder]
                movl (%edx, %ecx, 4), %eax      # inmatdata1[c+r*matorder]
                movl %eax, data1        # met le résultat dans data1
                movl (%edi, %ecx, 4), %eax      # inmatdata2[c+r*matorder]
                movl %eax, data2        # met le résultat dans data2

                # met la valeur data1 dans %eax
                movl data1, %eax
                cmp %eax, data2  # si data1 != data2 fait loop2end
                je LOOP2END
                # sinon retourne 0 dans %eax et met fin a la boucle
                movl $0, %eax
                jmp END1
        LOOP2END:
                addl $1, maColonne
                movl matOrder, %eax
                cmp maColonne, %eax
                je LOOP1END
                jmp LOOP2
        LOOP1END:
                addl $1, maRange
                cmp maRange, %edi
                je LOOP1
                jmp END2
        END2:
                movl $1, %eax
                jmp END1
        END1:
                popl %edi
                leave          /* Restore ebp and esp */
                ret            /* Return to the caller */