
#include <stdio.h>

unsigned int Decryption_fct(unsigned int le)
{
	unsigned int be;

	
	 //* Remplacez le code suivant par de l'assembleur en ligne
	 //* en utilisant le moins d'instructions possible
	 
	//be = (le & 0xff000000) | (le&0xff) << 16  | (le & 0xff00) | (le & 0xff0000) >> 16;
	 
	

	asm volatile (
		// instructions...
		"xchg %%ah, %%al;"
		"ror $16, %%eax;"
		"xchg %%ah, %%al;"
		"ror $8, %%eax;"
		: "=r"(le)// sorties (s'il y a lieu)
		: "r"(le) // entrées
		: // registres modifiés (s'il y a lieu)
	);

	return le;
}

int main()
{
	unsigned int data = 0xeeaabbff;

	printf("Représentation crypte en little-endian:   %08x\n"
	       "Représentation decrypte en big-endian:    %08x\n",
	       data,
	       Decryption_fct(data));

	return 0;
}
