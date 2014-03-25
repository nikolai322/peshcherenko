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
scanf("%d",&ebx);
for (ecx = 0; ecx < ebx; ecx++)
	eax = eax + ecx;
printf("%d",eax);
*/
	pushl $int_label
	pushl $format_string
	call scanf
	addl $8, %esp
	movl $0, %eax
	movl $0, %ecx
	movl int_label, %ebx	
loop_start:
	cmpl %ecx, %ebx
	je loop_end
	addl %ecx, %eax
	addl $1, %ecx
	jmp loop_start
loop_end:
//print
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
