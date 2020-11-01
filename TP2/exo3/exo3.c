#include <stdio.h>
#include <stdlib.h>

/* Modifiez ces définitions à votre guise afin de tester toutes les
conditions; elles correspondent aux valeurs initiales de a, b, c, d et e : */
#define INIT_A	20
#define INIT_B	700
#define INIT_C	300
#define INIT_D	140
#define INIT_E	-570

int a, b, c, d, e;

extern void q1_s(void);

static void q1_c(void) {
	int i;
	for (i=0; i<=10; i++){
		
		a = d + i + e - b;
		if ((b - 4000) < ( c - 500 )) {
			c = c + 500;
			if (b > c) {
				b = b + 1000;
			}
		} 
		else {
			b = b - e + i;
			d = d + 500 + a;
		}
		
	}
}

void init(void) {
	a = INIT_A;
	b = INIT_B;
	c = INIT_C;
	d = INIT_D;
	e = INIT_E;
}

int main(void) {
	
	init();

	printf("a = %d    b = %d    c = %d    d = %d    e = %d\n", a, b, c, d, e);
	printf("Le résultat devrait être le même les 3 fois :\n\n");
	q1_c();
	printf("Version en langage C : %i\n", a);

	init();

	q1_s();
	printf("\033[0;33mVersion en assembleur : %i\n\033[0m", a);
	
	init();

	q1_c();
	printf("Version en langage C : %i\n", a);

	return 0;
}
