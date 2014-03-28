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
	pushl $int_label
	pushl $format_string
	call scanf
	addl $8, %esp
/*This is a code that will be written in C like this:
int eax, ecx;
eax = 1;
scanf("%d",&ebx);
while (ecx < ebx)
	{
	eax = eax + ecx;
	ecx = ecx + 2;
	}
printf("%d",eax);
*/
	movl $0, %eax
	movl $1, %ecx
	movl int_label, %ebx	
loop_start:
	cmpl %ecx, %ebx
	je loop_end
	addl %ecx, %eax
	addl $2, %ecx
	jmp loop_start
loop_end:
//print
	pushl %eax
	pushl $format_string
	call printf
	addl $8, %esp
//epilog
  	pushl $pr
	call printf
	movl $0, %eax
	addl $8, %esp
	movl %ebp, %esp	
	popl %ebp
	ret
