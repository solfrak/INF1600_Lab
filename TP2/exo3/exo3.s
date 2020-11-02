.global q1_s

q1_s:
	/* VOTRE PROGRAMME ASSEMBLEUR ICI ...  */
    .data
    IT: .int 0
    
    .text

       #Prologue
       pushl %ebp
       movl %esp, %ebp
       movl $0, %edx

    L1:

       movl d, %eax       
       addl %edx, %eax    
       movl e, %ecx       
       addl %ecx, %eax     
       movl b, %ecx
       subl %ecx, %eax
       movl %eax, a        #Calcul de d+i+e-b
     
       subl $4000, %ecx 
       movl c, %eax
       subl $500, %eax 
       cmp  %eax, %ecx     #Comparer b-4000 < c-500
       jl IF    
       
       movl b, %eax
       movl e, %ecx     
       subl %ecx, %eax  
       addl %edx, %eax  
       movl %eax, b        #Calcul de b-e+i
      
           
       movl d, %eax     
       movl $500, %ecx
       addl %ecx, %eax     
       movl a, %ecx      
       addl %ecx, %eax
       movl %eax, d        #Calcul de d+500+a
        
        
        jmp FINBOUCLE
        
       
       
    FINBOUCLE:
       addl $1, %edx        #On incremente IT qui est dans le registre edx
       cmp $10, %edx        
       jle L1               #Si i <= 10, on refait la boucle
       jmp FIN
       
    
    FIN:
 
       #Epilogue
       popl %ebp 
	   ret
       
       
    IF:
        movl c, %eax   
        movl $500, %ecx
        addl %ecx, %eax
        movl %eax, c       #Calcul de c+500
        
        movl b, %ecx   
        cmp  %eax, %ecx    #Comparer b > c
        jg IF2
        jmp FINBOUCLE

    IF2: 
        movl $1000, %eax 
        addl %eax, %ecx
        movl %ecx, b        #Calcul b+1000
       
        jmp FINBOUCLE














