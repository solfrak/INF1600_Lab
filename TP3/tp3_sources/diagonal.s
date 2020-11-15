.global matrix_diagonal_asm

matrix_diagonal_asm:
        .data                   # Initialisation de variables d'itérations
        ITC: .int 0             # Compteur de colonnes
        ITR: .int 0             # Compteur de rangées
        .text

        push %ebp      /* Save old base pointer */
        mov %esp, %ebp /* Set ebp to current esp */
        
        # 1. Sauvegarder les registres dans la pile
        pushl %esi
        pushl %edi
        pushl %ebx

        # 2. Mettre les valeurs des parametres dans les registres 
        movl 8(%ebp), %esi          # Aller chercher inmatdata1
        movl 12(%ebp), %edi         # Aller chercher outmatdata
        movl 16(%ebp), %ebx         # Aller chercher matorder
        
        movl $0, ITR                # Initialiser le compteur de rangées
        LOOP1:
                movl $0, ITC            # Remettre le compteur de colonnes a 0 pour la prochaine rangées
               
                # 3. Test de continuité dans les rangées
                cmp ITR, %ebx           # Comparer le compteur de rangées avec le matorder
                je FIN                  # Si les deux valeurs sont égales alors on a passé toutes les valeurs des matrices, donc on saute a la fin du programme
        LOOP2:
                # 4. Test de continuité dans les colonnes
                cmp ITC, %ebx            # Comparer le compteur de colonnes avec le matorder
                je LOOP2END              # Si les deux valeurs sont égales alors on a passé toutes les colonnes, donc on saute a la fonction LOOP2END      

                # 5. Calcul de l'indice dans la matrice inmatdata
                movl ITR, %eax          # Mettre ITC dans un registre
                imul %ebx, %eax         # ITC * matorder
                add ITC, %eax           # ITR + (ITC * matorder)

                # 6. Déterminer si ITC est égal a ITR
                movl ITC, %ecx          # Mettre ITC dans un registre
                cmp %ecx, ITR          # Comparer ITC et ITR
                je IF                   # Si ils sont égaux, on saute dans la fonction IF, sinon on reste dans la boucle
                
                # 7. Mettre 0 dans la valeur de outmatdata a l'indice calculé, car ne fait pas parti de la diagonale
                movl $0, (%edi, %eax, 4)

                jmp LOOP1END            #On saute a la fonction de fin de boucle 

        IF:
                # 8. Aller chercher la valeur de la diagonale de inmatdata et la mettre dans outmatdata
                movl (%esi, %eax, 4), %edx      # Accéder a la valeur de inmatdata a l'indice calculé
                movl %edx, (%edi, %eax, 4)      # Mettre la valeur de inmatdata dans outmatdata a l'indice calculé
                
        LOOP1END:
                # 9. Fin de la boucle intérieur
                addl $1, ITC                # Itération du compteur de colonnes
                jmp LOOP2                   # On saute a la boucle 1 pour aller faire le test de continuité sur les colonnes

        LOOP2END:
                # 10. Fin de la boucle extérieure
                addl $1, ITR                # Itération du compteur de rangées
                jmp LOOP1                   # On saute a la boucle 1 pour aller faire le test de continuité sur les rangées

        FIN:
                # 11. Reprendre les valeurs initiales des registres et quitter le programme
                popl %ebx
                popl %edi
                popl %esi
                leave          /* Restore ebp and esp */
                ret            /* Return to the caller */

