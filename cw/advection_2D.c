#include <stdio.h>
#include <stdlib.h>
void print(int Nx, int Ny, double **current);
int main()
{
	int i, j, k;
//declaration of all variables we will need
	int Nx = 100;//Nx is the number of nodes alongside x axis
	int Ny = 100;
	double cx = 1.0;
	double cy = 1.0;
	double kx = 0.6;
	double ky = 0.6; 
	double **current = (double**)malloc(Nx*sizeof(double*));
	for (i = 0; i < Nx; i++)
		current[i] = (double*)malloc(Ny*sizeof(double));
	double **next = (double**)malloc(Nx*sizeof(double*));
	for (i = 0; i < Nx; i++)
		next[i] = (double*)malloc(Ny*sizeof(double));
	double **temp = (double**)malloc(Nx*sizeof(double*));
	for (i = 0; i < Nx; i++)
		temp[i] = (double*)malloc(Ny*sizeof(double));
//initialization
	double taux, tauy, hx, hy;
	hx = 2.0/Nx;
	hy = 2.0/Ny;
	taux = kx*hx/cx;
	tauy = ky*hy/cy;
	for (i = 0; i < Nx; i++)
		for (j = 0; j < Ny; j++)
		{
		if ( ((-1.0 + i*hx) >= -0.5 ) && ((-1.0 + i*hx) <= 0.5 ) )
			if ( ((-1.0 + j*hy) >= -0.5 ) && ((-1.0 + j*hy) <= 0.5 ) )
			current[i][j] = 1.0;
		else
			current[i][j] = 0.0;
		next[i][j] = 0.0;
		temp[i][j] = 0.0;
		}
	print(Nx, Ny, current);
//main loop
	double a, b;
	int steps = 0;
	int w, z;
	w = 0;
	z = 0;
	while (w < 2/(cy*tauy))
		while (z < 2/(cx*taux))
		{
//shear alongside x axis
		for (k = 0; k < Ny; k++)
			{	
		for (j = 0; j < Nx-1; j++)
			{
			a = (current[j+1][k]-current[j][k])/hx;
			b = ( (-1.0 + (j+1)*hx)*current[j][k] - (-1.0 + j*hx)*current[j+1][k] )/hx;
			temp[j+1][k] = a*(-1.0 + (j+1)*hx - cx*taux) + b;
			}
			a = (current[0][k]-current[Nx-1][k])/hx;
			b = ( (-1.0 + Nx*hx)*current[Nx-1][k] - (-1.0 + (Nx-1)*hx)*current[0][k] )/hx;
			temp[0][k] = a*(-1.0 + Nx*hx - cx*taux) + b;
			}
		w++;
//shear alongside y axis
		for (k = 0; k < Nx; k++)
			{	
		for (j = 0; j < Ny-1; j++)
			{
			a = (temp[k][j+1]-temp[k][j])/hy;
			b = ( (-1.0 + (j+1)*hy)*temp[k][j] - (-1.0 + j*hy)*temp[k][j+1] )/hy;
			next[k][j+1] = a*(-1.0 + (j+1)*hy - cy*tauy) + b;
			}
			a = (temp[k][0]-temp[k][Ny-1])/hx;
			b = ( (-1.0 + Ny*hy)*temp[k][Ny-1] - (-1.0 + (Ny-1)*hy)*temp[k][0] )/hy;
			next[k][0] = a*(-1.0 + Ny*hy - cy*tauy) + b;
			}
		z++;
//current array update
		for (k = 0; k < Ny; k++)	
			for (j = 0; j < Nx; j++)
				current[j][k] = next[j][k];
		print(Nx, Ny, current);
		}
	return 0;
}
void print(int Nx, int Ny, double **current)
{
/*	printf("x     ");
	printf("y     ");
	printf("u(x,y)     \n");
*/	int k ,j;
	for (k = 0; k < Ny; k++)	
		{
		for (j = 0; j < Nx; j++)
			printf("%f ", current[j][k]);
		printf("\n");
		}
	printf("\n");	
}
