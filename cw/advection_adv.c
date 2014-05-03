#include <stdio.h>
#include <stdlib.h>
#include "drawme.h"
void print(int N, double *current);
int main()
{
int i;
int N = 50;//N is the number of nodes
double cx = 1.0;
double k = 0.6;
double *current = (double *)malloc(N*sizeof(double));
double *next = (double *)malloc(N*sizeof(double));
double *current_der = (double *)malloc(N*sizeof(double));
double *next_der = (double *)malloc(N*sizeof(double));
double *x = (double *)malloc(N*sizeof(double));
//initialization
double tau, h;
h = 2.0/N;
tau = k*h/cx;
for (i = 0; i < N; i++)
{
if ( ((-1.0 + i*h) >= -0.5 ) && ((-1.0 + i*h) <= 0.5 ) )
current[i] = 1.0;
else
current[i] = 0.0;
next[i] = 0.0;
current_der[i] = 0.0;
next_der[i] = 0.0;
x[i] = -1.0 + i*h;
}
// print(N, current);
DM_plot_1d(x, current, N, "Text", 1);
//main loop
int j;
double a, b, c, d, A, B, C, D, E, F, x0;
double xm, xm_1, um, um_1, dum, dum_1;
//here um stands for a u(xm), dum for derivative of u in xm
//extrapolation as a polinom ax^3+bx^2+cx+d
i = 0;
while (i < 1)
{
for (j = 0; j < N-1; j++)
{
//description of new values
um = current[j+1];
um_1 = current[j];
dum = current_der[j+1];
dum_1 = current_der[j];
xm_1 = -1.0 + j*h;
xm = -1.0 + (j+1)*h;
//calcualtion of coefficients
A = xm_1*xm_1*xm*xm*(xm - xm_1);
B = xm_1*xm*(xm*xm - xm_1*xm_1);
C = um_1*xm*xm*xm - um*xm_1*xm_1*xm_1;
D = 2*xm_1*xm*(xm - xm_1);
E = xm*xm - xm_1*xm_1;
F = dum_1*xm*xm - dum*xm_1*xm_1;
b = (C*E - F*B)/(A*E - D*B);
c = (A*F - D*C)/(A*E - D*B);
a = (dum_1 - c - 2*b*xm_1)/(3*xm_1*xm_1);
d =um_1 - c*xm_1 - b*xm_1*xm_1 - a*xm_1*xm_1*xm_1;
x0 = xm - cx*tau;
//recalculation of funciton and its derivative
next[j+1] = a*x0*x0*x0 + b*x0*x0 + c*x0 + d;
next_der[j+1] = 3*a*x0*x0 + 2*b*x0 + c;
}
//the same for the border layer
um = current[0];
um_1 = current[N-1];
dum = current_der[0];
dum_1 = current_der[N-1];
xm_1 = -1.0 + (N-1)*h;
xm = -1.0 + N*h;

A = xm_1*xm_1*xm*xm*(xm - xm_1);
B = xm_1*xm*(xm*xm - xm_1*xm_1);
C = um_1*xm*xm*xm - um*xm_1*xm_1*xm_1;
D = 2*xm_1*xm*(xm - xm_1);
E = xm*xm - xm_1*xm_1;
F = dum_1*xm*xm - dum*xm_1*xm_1;
b = (C*E - F*B)/(A*E - D*B);
c = (A*F - D*C)/(A*E - D*B);
a = (dum_1 - c - 2*b*xm_1)/(3*xm_1*xm_1);
d = um_1 - c*xm_1 - b*xm_1*xm_1 - a*xm_1*xm_1*xm_1;
x0 = xm - cx*tau;
next[0] = a*x0*x0*x0 + b*x0*x0 + c*x0 + d;
next_der[0] = 3*a*x0*x0 + 2*b*x0 + c;

//current arrays update
for (j = 0; j < N; j++)
{
current[j] = next[j];
current_der[j] = next_der[j];
}
DM_plot_1d(x, current, N, "Text", 1);
if (current[0] != 0)
i++;
}
return 0;
}
void print(int N, double *current)
{
int i;
for (i = 0; i < N; i++)
printf("%lf ",current[i]);
printf("\n");
}

