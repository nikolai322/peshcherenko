#include <stdio.h>
#include <stdlib.h>
#include "drawme.h"
#include <math.h>
void print(int N, double *current);
int main()
{
	int i;
	int N = 100;//N is the number of nodes
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
	float eps = 0.0000001;
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
  	DM_plot_1d(x, current, N, "Text", 1);
//	print(N, current);
//main loop
	int j;
	double a, b, c, d, A, B, C, D, E, F, x0;
	double xm, xm_1, um, um_1, dum, dum_1;
//here um stands for a u(xm), dum for derivative of u in xm
//extrapolation as a polinom ax^3+bx^2+cx+d
	i = 0;
	while (i < 1000)
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
			x0 = xm - cx*tau;
			if ( (fabs(xm-0.0) > eps) && (fabs(xm_1-0.0) > eps) )
				{
//calculation of coefficients
				A = -0.5*(xm_1*xm_1*xm_1 - xm*xm*xm);
				B = 0.5*(xm_1 - xm);
				C = um_1 - um +0.5*(xm*dum - xm_1*dum_1);
				D = -3.0*xm_1*xm*(xm - xm_1);
				E = xm - xm_1;
				F = dum_1*xm - dum*xm_1;
				a = (C*E - F*B)/(A*E - D*B);
				c = (A*F - D*C)/(A*E - D*B);
				b = (dum - 3.0*a*xm*xm - c)/(2.0*xm);
				d = um - c*xm - b*xm*xm - a*xm*xm*xm;
				}
			if (fabs(xm_1-0.0) < eps)
				{
				d = um_1;
				c = dum_1;
				A = um-c*xm-d;
				B = dum-c;
				a = -(A*2.0-B*xm)/(xm*xm*xm);
				b = -(xm*B-3.0*A)/(xm*xm);
				}
			if (fabs(xm-0.0) < eps)
				{
				d = um;
				c = dum;
				A = um_1-c*xm_1-d;
				B = dum_1-c;
				a = -(A*2.0-B*xm_1)/(xm_1*xm_1*xm_1);
				b = -(xm_1*B-3.0*A)/(xm_1*xm_1);
				}
//recalculation of function and its derivative
			next[j+1] = a*x0*x0*x0 + b*x0*x0 + c*x0 + d;
			next_der[j+1] = 3.0*a*x0*x0 + 2.0*b*x0 + c;
			}
//the same for the border layer
		um = current[0];
		um_1 = current[N-1];
		dum = current_der[0];
		dum_1 = current_der[N-1];
		xm_1 = -1.0 + (N-1)*h;
		xm = -1.0 + N*h;
		x0 = xm - cx*tau;
		A = -0.5*(xm_1*xm_1*xm_1 - xm*xm*xm);
		B = 0.5*(xm_1 - xm);
		C = um_1 - um +0.5*(xm*dum - xm_1*dum_1);
		D = -3.0*xm_1*xm*(xm - xm_1);
		E = xm - xm_1;
		F = dum_1*xm - dum*xm_1;
		a = (C*E - F*B)/(A*E - D*B);
		c = (A*F - D*C)/(A*E - D*B);
		b = (dum - 3.0*a*xm*xm - c)/(2.0*xm);
		d = um - c*xm - b*xm*xm - a*xm*xm*xm;
		next[0] = a*x0*x0*x0 + b*x0*x0 + c*x0 + d;
		next_der[0] = 3.0*a*x0*x0 + 2.0*b*x0 + c;
//current arrays update
		for (j = 0; j < N; j++)
			{
			current[j] = next[j];
			current_der[j] = next_der[j];
			}
		DM_plot_1d(x, current, N, "Text", 1);
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
