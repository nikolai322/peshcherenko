.data
int:
	.space 4
fmt_print:
	.string "%d\n"
fmt_string:
	.string "%d"
.text
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
//main program
	pushl $int
	pushl $fmt_string
	call scanf
	addl $8, %esp
	movl int, %edx #absolute	
	movl $12, %ecx
	movl $int, %ebx
	movl (%ebx), %eax
	pushl %eax
	pushl %ecx	 
	pushl %edx
	pushl $fmt_print
	call printf
	addl $8, %esp
	
	popl %ecx 
	movl %ecx, int
	pushl int
	pushl $fmt_print
	call printf
	addl $8, %esp
	
	pushl $fmt_print
	call printf
	addl $8, %esp
//epilog
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
