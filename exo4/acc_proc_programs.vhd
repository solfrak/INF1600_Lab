use work.acc_proc_def.all;

package acc_proc_programs is

   -- Le contenu de la memoire est uint16, 
   -- ce qui explique l'utilisation de fonctions
   -- de conversion

   -- Programme utilise pour les questions 1, 2 et 3 (bonus)
   constant program_0 : memtype := (
      to_uint16((ld,   7)),   --  0 
      to_uint16((mul, 10)),   --  1
      to_uint16((add,  8)),   --  2
      to_uint16((mul, 10)),   --  3
      to_uint16((add,  9)),   --  4
      to_uint16((st,  11)),   --  5
      to_uint16((stop, 0)),   --  6 
      +1,                     --  7 : a
      int16_to_uint16(-2),    --  8 : b
      +1,                     --  9 : c
      int16_to_uint16(-1),    -- 10 : x
      int16_to_uint16(0),     -- 11 : y
      others => 0
   );

    
   -- Programme utilise pour les questions 4&5
   constant program_1 : memtype := (
      -- ECRIRE VOTRE PROGRAMME ICI
      -- UNE LIGNE PAR INSTRUCTION
      --
      to_uint16((ld, 10)),
      to_uint16((add, 11)),
      to_uint16((st, 12)),
      to_uint16((add, 11)),
      to_uint16((st, 13)),
      to_uint16((add, 12)),
      to_uint16((st, 14)),
      to_uint16((add, 13)),
      to_uint16((st, 15)),
      to_uint16((stop, 0)),
      0,                      -- Fib(0)
      1,                      -- Fib(1)
      0,                      -- Fib(2)
      0,                      -- Fib(3)
      0,                      -- Fib(4)
      0,                      -- Fib(5)
      others => 0
   );
   
end acc_proc_programs;

package body acc_proc_programs is  
end acc_proc_programs;
