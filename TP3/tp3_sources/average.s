.global matrix_row_aver_asm

matrix_row_aver_asm:
        .data                   # Initialisation de variables d'itérations
        ITC: .int 0             # Compteur de colonnes
        ITR: .int 0             # Compteur de rangées
        BUFF: .int 0            # Buffer pour calculer les éléments
        .text

        push %ebp               # Save old base pointer 
        mov %esp, %ebp           # Set ebp to current esp

        # 1. Sauvegarder les registres dans la pile
        pushl %esi
        pushl %edi
        pushl %ebx

        # 2. Mettre les valeurs des parametres dans les registres 
        movl 8(%ebp), %esi      # Aller chercher inmatdata
        movl 12(%ebp), %edi     # Aller chercher outmatdata
        movl 16(%ebp), %ebx     # Aller chercher matorder
        
        movl $0, ITR                # Initialiser le compteur de rangées
        
        LOOP1:
                movl $0, ITC        # Remettre le compteur de colonnes a 0 pour la prochaine rangée
                movl $0, BUFF       # Remettre le buffer a 0 pour le prochain calcul
                
                # 3. Test de continuité sur les rangées
                cmp ITR, %ebx           # Comparer le compteur de rangées avec le matorder
                je FIN                  # Si égales, fin des rangées

        LOOP2:
                # 4. Test de continuité sur les colonnes
                cmp ITC, %ebx           # Comparer le compteur de colonnes avec le matorder
                je LOOP2END             # Si égales, fin de la colonne 

                # 6. Calcule de l'indice
                movl ITR, %eax          # Mettre ITR dans un registre
                imul %ebx, %eax         # ITR * matorder
                addl ITC, %eax          # ITC + (ITR * matorder)

                # 7. Accèder à la valeur dans la matrice inmatdata et l'additionner au buffer
                movl (%esi, %eax, 4), %edx      # Accéder a la valeur de inmatdata a l'indice calculé
                addl %edx, BUFF                 # Additionner la valeur aux autres éléments additionner

                # 10. On itère le compteur de colonnes et on revient au début de la boucle 
                addl $1, ITC            # Itération du compteur de colonnes
                jmp LOOP2               # On saute au début de la boucle pour faire le test de continuation sur les colonnes

        LOOP2END:
                # 11. Calcule de la moyenne en divisant les éléments additionnés par l'ordre de la matrice
                movl ITR, %ecx          # Mettre ITR dans un registre, car indice ou mettre le resultat
                movl $0, %edx           # Mettre le registre a 0, au cas ou il y a débordement dans la division
                movl BUFF, %eax         # Mettre BUFF dans un registre
                idiv %ebx               # diviser le registre %eax par matorder (%ebx)
                movl %eax, (%edi, %ecx, 4)      # Mettre le resultat de la division dans la matrice de sortie a l'indice voulue 

                # 12. On itere le compteur de rangées et on saute pour faire le test de continuité sur les rangées
                addl $1, ITR            # Itération du compteur de rangées
                jmp LOOP1               # On saute au debut de la boucle 1
	
        FIN:
                # 13. Reprendre les valeurs initiales des registres et quitter le programme
                popl %esi
                popl %edi
                popl %ebx
                leave          	        # Restore ebp and esp 
                ret           	        # Return to the caller 
		
