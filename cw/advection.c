#include <stdio.h>
#include <stdlib.h>
void print(int N, double *current);
int main()
{
	int i;
	int N = 20;//N is the number of nodes
	double cx = 1.0;
	double k = 0.6;
	double *current = (double *)malloc(N*sizeof(double));
	double *next = (double *)malloc(N*sizeof(double));
//	double current [10];
//	double next [10];	
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
		}
	print(N, current);
//main loop
	int j;
	double a, b;
	i = 0;
	while (i < 2/(cx*tau)) //1 period
		{
		for (j = 0; j < N-1; j++)
			{
			a = (current[j+1]-current[j])/h;
			b = ( (-1.0 + (j+1)*h)*current[j] - (-1.0 + j*h)*current[j+1] )/h;
			next[j+1] = a*(-1.0 + (j+1)*h - cx*tau) + b;
			}
			a = (current[0]-current[N-1])/h;
			b = ( (-1.0 + N*h)*current[N-1] - (-1.0 + (N-1)*h)*current[0] )/h;
			next[0] = a*(-1.0 + N*h - cx*tau) + b;
//current array update
		for (j = 0; j < N; j++)
			current[j] = next[j];
		print(N, current);
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
