.global matrix_multiply_asm

matrix_multiply_asm:
        .data                   # Initialisation de variables d'itérations
        ITC: .int 0             # Compteur de colonnes
        ITR: .int 0             # Compteur de rangées
        INDEX: .int 0           # Compteur de l'index
        BUFF: .int 0            # Buffer pour calculer les éléments
        .text

        push %ebp      /* Save old base pointer */
        movl %esp, %ebp /* Set ebp to current esp */

        # 1. Sauvegarder les registres dans la pile
        pushl %esi
        pushl %edi
        pushl %ebx

        # 2. Mettre les valeurs des parametres dans les registres 
        movl 8(%ebp), %esi      # Aller chercher inmatdata1
        movl 12(%ebp), %edi     # Aller chercher inmatdata2
        movl 20(%ebp), %ebx     # Aller chercher matorder
        
        movl $0, ITR                # Initialiser le compteur de rangées
        LOOP1:
                movl $0, ITC        # Remettre le compteur de colonnes a 0 pour la prochaine rangées
                
                # 3. Test de continuité dans les rangées
                cmp ITR, %ebx           # Comparer le compteur de rangées avec le matorder
                je FIN                  # Si les deux valeurs sont égales alors on a passé toutes les valeurs des matrices, donc on saute a la fin du programme

        LOOP2:
                movl $0, BUFF           # Remettre le buffer a 0 pour le prochain calcul
                movl $0, INDEX          # Remettre le compteur de colonnes a 0 pour la prochaine rangées
                
                # 4. Test de continuité dans les colonnes
                cmp ITC, %ebx           # Comparer le compteur de rangées avec le matorder
                je LOOP2END             # Si les deux valeurs sont égales alors on a passé toutes les colonnes, donc on saute a la fonction LOOP2END      

        LOOP3:     
                # 5. Test de continuité dans les éléments
                cmp INDEX, %ebx         # Comparer le nombre d'éléments parcourus avec le matorder
                je LOOP3END             # Si les deux valeurs sont égales alors on a passé toutes les éléments, donc on saute a la fonction LOOP3END

                # 6. Calculer l'indice et accèder à la valeur dans la matrice inmatdata1 
                movl ITR, %eax          # Mettre ITR dans un registre
                imul %ebx, %eax         # ITR * matorder
                addl INDEX, %eax        # INDEX + (ITR * matorder)

                movl (%esi, %eax, 4), %ecx      # Accéder a la valeur de inmatdata1 a l'indice calculé

                # 7. Calculer l'indice et accèder à la valeur dans la matrice inmatdata2
                movl INDEX, %eax        # Mettre INDEX dans un registre
                imul %ebx, %eax         # INDEX * matorder
                addl ITC, %eax          # ITC + (INDEX * matorder)

                movl (%edi, %eax, 4), %edx      # Accéder a la valeur de inmatdata2 a l'indice calculé

                # 8. Calculer la multiplication des éléments
                imul %ecx, %edx         # Multiplier élément de inmatdata1 et inmatdata2
                addl %edx, BUFF         # Ajouter le resultat au Buffer
                movl BUFF, %ecx         # Mettre le Buffer dans un registre

                # 9. Calculer l'indice et accèder à l'addresse voulue de outmatdata
                movl ITR, %eax          # Mettre ITR dans un registre
                imul %ebx, %eax         # ITR * matorder
                addl ITC, %eax          # ITC + (ITR * matorder)

                movl 16(%ebp), %edx     # Aller chercher outmatdata
                movl %ecx, (%edx, %eax, 4)      # Mettre le reésultat de la multiplication dans la matrice outmatdata a l'indice calculé

                # 10. On itère l'index pour accéder aux valeurs suivantes dans les colonnes/rangées des matrices d'input
                addl $1, INDEX          # Itération de l'index
                jmp LOOP3               # On saute au debut de la boucle 3 pour aller faire le test de continuité sur les indexs

        LOOP3END:
                # 11. Fin de la multiplication pour un élément, on passe a la prochaine colonne
                add $1, ITC             # Itération du compteur de colonnes
                jmp LOOP2               # On saute a la boucle 2 pour aller faire le test de continuité sur les colonnes

        LOOP2END:
                # 12. Fin de la rangée, on itère et passe a la prochaine rangée
                add $1, ITR             # Itération du compteur de rangée
                jmp LOOP1               # On saute a la boucle 1 pour aller faire le test de continuité sur les rangées

        
        FIN:
                # 13. Reprendre les valeurs initiales des registres et quitter le programme
                popl %ebx
                popl %edi
                popl %esi
                leave          /* Restore ebp and esp */
                ret            /* Return to the caller */

