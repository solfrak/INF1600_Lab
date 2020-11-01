#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

float a, b, c, d, e, f, g, theta;
// CONSTANTE OPTIONNELLE POUR VOUS AIDER DANS VOTRE PROGRAMME ASSEMBLEUR
float constant = 2;

extern void q1_s(void);
extern void q2_s(void);

static void q1_c(void) {
	a = ((b + c) / d) * (((e * d) - b) / (g + f) - f);
}

static void q2_c(void) {
	c = sqrt((a*a) + (b*b) - (2*a*b*cos(theta)));
}

int main(void) {
	srand48(time(0));
	a = drand48();
	b = drand48();
	c = drand48();
	d = drand48();
	e = drand48();
	f = drand48();
	g = drand48();
	

	printf("\033[1;31mQ1 ---------------------\n\033[0m");
	printf("Le résultat devrait être le même les 3 fois :\n\n");
	q1_c();
	printf("Version en langage C : %f\n", a);
	a = 0xdeadbeef;
	q1_s();
	printf("\033[0;33mVersion en assembleur : %f\n\033[0m", a);
	q1_c();
	printf("Version en langage C : %f\n", a);
	

	a = drand48();
	b = drand48();
	theta= drand48();

	printf("\n\033[1;31mQ2 ---------------------\n\033[0m");
	printf("Le résultat devrait être le même les 3 fois :\n\n");
	q2_c();
	printf("Version en langage C : %f\n", c);
	c = 0xdeadbeef;
	q2_s();
	printf("\033[0;33mVersion en assembleur : %f\n\033[0m", c);
	q2_c();
	printf("Version en langage C : %f\n", c);


	return 0;
}