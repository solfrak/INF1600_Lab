.global matrix_transpose_asm

matrix_transpose_asm:     
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
        movl 12(%ebp), %edi         # Aller chercher inmatdata2
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

                # 5. Calcul de l'indice dans la matrice inmatdata et accéder a la valeur dans la matrice
                movl ITC, %eax          # Mettre ITC dans un registre
                imul %ebx, %eax         # ITC * matorder
                add ITR, %eax           # ITR + (ITC * matorder)

                movl (%esi, %eax, 4), %edx      # Accéder a la valeur de inmatdata a l'indice calculé
                
                # 6. Calcul de l'indice dans la matrice inmatdata
                movl ITR, %eax          # Mettre ITC dans un registre
                imul %ebx, %eax         # ITC * matorder
                add ITC, %eax           # ITR + (ITC * matorder)

                movl %edx, (%edi, %eax, 4)      # Mettre la valeur de inmatdata dans outmatdata a l'indice calculé
                
                # 7. Fin de la colonne
                addl $1, ITC                # Itération du compteur de colonnes
                jmp LOOP2                   # Retour a la boucle 2 pour faire le test de continuité
                
        LOOP2END:
                # 8. Fin d'une rangée
                addl $1, ITR                # Itération du compteur de rangées
                jmp LOOP1                   # On saute a la boucle 1 pour faire le test de continuité

        FIN:
                # 9. Reprendre les valeurs initiales et quitter le programme
                popl %ebx
                popl %edi
                popl %esi
                leave                   # Restore ebp and esp 
                ret                     # Return to the caller 

                