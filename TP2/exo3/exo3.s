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
       movl %eax, a
     
       
       subl $4000, %ecx
       movl c, %eax
       subl $500, %eax 
       cmp  %eax, %ecx
       jl IF 
       
        movl b, %eax
        movl e, %ecx     #e
        subl %ecx, %eax  #b-e
        addl %edx, %eax  #b-e+i
        movl %eax, b
      
           
        movl d, %eax      #Prendre d 
        movl $500, %ecx
        addl %ecx, %eax  #d+500
       
        movl a, %ecx      #Prendre a
        addl %ecx, %eax
        movl %eax, d     #Mettre d 
        
        
        jmp FINBOUCLE
        
       
       
    FINBOUCLE:
       addl $1, %edx
       cmp $10, %edx
       jle L1
       jmp FIN
       
    
    FIN:
 
       #Epilogue
       popl %ebp 
	   ret
       
       
    IF:
        movl c, %eax   #Prendre c
        movl $500, %ecx
        addl %ecx, %eax
        movl %eax, c    #save c
        
        movl b, %ecx    #Prendre b
        cmp  %eax, %ecx
        jg IF2
        jmp FINBOUCLE

    IF2: 
        movl $1000, %eax
        addl %eax, %ecx
        movl %ecx, b    #save b
       
        jmp FINBOUCLE














