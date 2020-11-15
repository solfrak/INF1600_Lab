.global matrix_diagonal_asm

matrix_diagonal_asm:
        .data                   # Initialisation de variables d'itérations
        ITC: .int 0             # Compteur de colonnes
        ITR: .int 0             # Compteur de rangées
        .text

        push %ebp               # Save old base pointer 
        mov %esp, %ebp          # Set ebp to current esp
        
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
                movl $0, ITC            # Remettre le compteur de colonnes a 0 pour la prochaine rangée
               
                # 3. Test de continuité dans les rangées
                cmp ITR, %ebx           # Comparer le compteur de rangées avec le matorder
                je FIN                  # Si égales, fin des rangées

        LOOP2:
                # 4. Test de continuité dans les colonnes
                cmp ITC, %ebx            # Comparer le compteur de colonnes avec le matorder
                je LOOP2END              # Si égales, fin de la colonne     

                # 5. Calcul de l'indice dans la matrice inmatdata
                movl ITR, %eax          # Mettre ITC dans un registre
                imul %ebx, %eax         # ITC * matorder
                add ITC, %eax           # ITR + (ITC * matorder)

                # 6. Déterminer si ITC est égal a ITR
                movl ITC, %ecx          # Mettre ITC dans un registre
                cmp %ecx, ITR           # Comparer ITC et ITR
                je IF                   # Si ils sont égaux, on saute dans la fonction IF, sinon on reste dans la boucle
                
                # 7. Mettre 0 dans la valeur de outmatdata a l'indice calculé, car ne fait pas parti de la diagonale
                movl $0, (%edi, %eax, 4)

                jmp LOOP1END            # Fin de la colonne

        IF:
                # 8. Construction de la diagonale
                movl (%esi, %eax, 4), %edx      # Accéder a la valeur de inmatdata a l'indice calculé
                movl %edx, (%edi, %eax, 4)      # Mettre la valeur de inmatdata dans outmatdata a l'indice calcul
                
        LOOP1END:
                # 9. Prochaine colonne
                addl $1, ITC                # Itération du compteur de colonnes
                jmp LOOP2                   # On saute a la boucle 2 pour faire le test de continuité

        LOOP2END:
                # 10. Prochaine rangée
                addl $1, ITR                # Itération du compteur de rangées
                jmp LOOP1                   # On saute a la boucle 1 pour faire le test de continuité 

        FIN:
                # 11. Reprendre les valeurs initiales des registres et quitter le programme
                popl %ebx
                popl %edi
                popl %esi
                leave          # Restore ebp and esp 
                ret            # Return to the caller 

