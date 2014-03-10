#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int main()
{
	char arg1[10];
	char arg2[10];
	char op[1];
	int res, a, b;
	scanf("%s",arg1);
	a = atoi(arg1);
	scanf("%s",arg2);
	if ( (arg2[0]!='i') && (arg2[0]!='d') )
		{
		b = atoi(arg2);
		scanf("%s",op);
		}
		else 
			{
			b = 0;
			op[0] = arg2[0];
			}
	printf("%d\n",a);
	printf("%d\n",b);
	if (op[0]=='+')
		printf("Sum=%d\n",my_sum(a,b) );
	if (op[0]=='-')
		printf("Sub=%d\n",my_sub(a,b) );
	if (op[0]=='*')
		printf("Mul=%d\n",my_mul(a,b) );
	if (op[0]=='/')
		printf("Div=%d\n",my_div(a,b) );
	if (op[0]=='i')
		printf("Inc=%d\n",my_inc(a,b) );
	if (op[0]=='d')
		printf("Dec=%d\n",my_dec(a,b) );
	return 0;
}
