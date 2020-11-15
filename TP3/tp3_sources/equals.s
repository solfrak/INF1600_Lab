
.global matrix_equals_asm

matrix_equals_asm:
        .data                   # Initialisation de variables d'itérations
        ITC: .int 0             # Compteur de colonnes
        ITR: .int 0             # Compteur de rangées
        .text

        push %ebp               # Save old base pointer 
        mov %esp, %ebp          # Set ebp to current esp
        
        # 1. Sauvegarder les registres dans la pile
        pushl %ebx
        pushl %esi
        pushl %edi
        
        # 2. Mettre les valeurs des parametres dans les registres 
        movl 8(%ebp), %edx          # Aller chercher inmatdata1
        movl 12(%ebp), %ecx         # Aller chercher inmatdata2
        movl 16(%ebp), %ebx         # Aller chercher matorder
        
       
        movl $0, ITR                # Initialiser le compteur de rangées   
        
        LOOP1:            
                movl $0, ITC            # Remettre le compteur de colonnes a 0 pour la prochaine rangées
                
                # 3. Test de continuité dans les rangées
                cmp ITR, %ebx           # Comparer le compteur de rangées avec le matorder
                je EQUAL                # Si les deux valeurs sont égales alors on a passé toutes les valeurs des matrices donc les matrices sont égales
        LOOP2:
                # 4. Test de continuité dans les colonnes
                cmp ITC, %ebx            # Comparer le compteur de colonnes avec le matorder
                je LOOP2END              # Si les deux valeurs sont égales alors on a passé toutes les valeurs de la colonne donc on saute a la fonction LOOP1END      
                
                
                # 5. Calcul de l'indice dans la matrice inmatdata1
                movl ITR, %eax              # Mettre ITR dans un registre
                imul %ebx, %eax             # ITR * matorder
                add ITC, %eax               # ITC + (ITR*matorder)
                
                movl (%edx, %eax, 4), %esi  # Accéder a inmatdata1 a l'indice calculé
                movl (%ecx, %eax, 4), %edi  # Accéder a inmatdata2 a l'indice calculé

                # 6. Déterminer si les valeurs trouvées en 4 sont égales
                cmp %esi, %edi              # Comparer les valeurs prises dans les deux matrices
                jne NOTEQUAL                # Si les valeurs ne sont pas égale on saute a la fonction NOTEQUAL sinon on continue dans la boucle

                # 7. Itérer le compteur de colonnes et on recommence la boucle pour aller faire le test de continuité sur les colonnes
                addl $1, ITC                # Itération du compteur de rangées
                jmp LOOP2                   # On saute a la boucle 2 

        LOOP2END:
                # 8. Fin de la boucle intérieur
                addl $1, ITR                # Itération du compteur de rangées
                jmp LOOP1                   # On saute a la boucle 1 pour aller faire le test de continuité sur les rangées

        EQUAL:
                # 9. Les deux matrices sont égales, alors on retourne 1
                movl $1, %eax               # mettre 1 dans le registre eax (registre de sortie) pour que la valeur de retour soit 1
                jmp FIN                     # On saute a la fin du programme
                                    
        NOTEQUAL: 
                # 10. Les deux matrices ont au moins un élément qui n'est pas égale, alors on retourne 0
                movl $0, %eax               # mettre 0 dans le registre eax (registre de sortie) pour que la valeur de retour soit 0  
                jmp FIN                     # On saute a la fin du programme
       
        FIN:
                # 11. Reprendre les valeurs initiales et quitter le programme
                popl %edi
                popl %esi
                popl %ebx
                leave          /* Restore ebp and esp */
                ret            /* Return to the caller */

               
