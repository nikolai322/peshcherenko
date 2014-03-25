.data
format_string:
	.string "%d"
int_label:
	.space 4
pr:
  .string "\n"
.text
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
/*This is a code that will be written in C like this:
int eax, ecx;
eax = 0;
scanf("%d",&ecx);
do
{
	eax = eax + ecx;
}
while (--ecx);
	printf("%d",eax);
*/
	pushl $int_label
	pushl $format_string
	call scanf
	addl $8, %esp
	movl int_label, %ecx
	movl $0, %eax
sum:
	addl %ecx, %eax
	loop sum
	pushl %eax
	pushl $format_string
	call printf
	pushl $pr
	call printf
	addl $12, %esp
//epilog
  movl $0, %eax
	movl %ebp, %esp	
	popl %ebp
	ret
