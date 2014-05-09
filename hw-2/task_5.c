#include <stdio.h>
#include <stdlib.h>
float sum2(float *b, int m);
int main()
{
	int i;
	int n, m;
	scanf("%d",&n);
	int *a = (int *)malloc(n*sizeof(int));
	for (i = 0; i < n; i++)
		scanf("%d",&a[i]);
	printf("%d\n",sum1(a,n));
	scanf("%d",&m);
	float *b = (float *)malloc(m*sizeof(float));
	for (i = 0; i < m; i++)
		scanf("%f",&b[i]);
	printf("%f\n",sum2(b,m));
	return 0;
}
