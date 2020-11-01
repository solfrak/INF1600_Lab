use work.acc_proc_def.all;

package acc_proc_programs is

   -- Le contenu de la memoire est uint16, 
   -- ce qui explique l'utilisation de fonctions
   -- de converssion
   constant program_0 : memtype := (
      to_uint16((ld,   7)),   --  0 
      to_uint16((br,   3)),   --  1
      to_uint16((ld,   8)),   --  2
      to_uint16((brz,  5)),   --  3
      to_uint16((add,  9)),   --  4
      to_uint16((brnz, 1)),   --  5
      to_uint16((stop, 0)),   --  6
      +2,                     --  7
      +1,                     --  8
      int16_to_uint16(-1),    --  9
      others => 0
   );

   constant program_1 : memtype := (
      to_uint16((lda, 13 )), --adress fib(o)   --0 
      to_uint16((ldi, 0)), ---fib(0) --1
      to_uint16((adda, 14)), --cste --2
      to_uint16((addx, 0)), --fib(1) + fib(0) --3
      to_uint16((adda, 14)), --fib(1) --4
      to_uint16((sti, 0)),  --store --5
      to_uint16((suba, 14)), --ctse --6
      to_uint16((ld,   12)), --it --7
      to_uint16((sub,  14)), --cste--8
      to_uint16((st,  12)), --it--9
      to_uint16((brnz, 1)),--10
      to_uint16((stop, 0)), 
      4,                      -- nb iterations 12
      15,                       -- address Fib(0) 13
      1,                      -- constante permettant de faire +1 ou -1 14
      0,                      -- Fib(0) 15 
      1,                      -- Fib(1) 16
      others => 0
   );
   
end acc_proc_programs;

package body acc_proc_programs is  
end acc_proc_programs;
