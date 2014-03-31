.data
fmt_string:
	.string "%s"
fmt_int:
	.string "%d\n"
count:
	.space 4
/*
char [50]
*/
/*
This is 0 as an end-of- line  symbol
*/
s:
	.space 50
s_end:
.text

.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
//main program
	pushl $s
	pushl $fmt_string
	call scanf
	movl $0, %eax
	movl %eax, count
start:
	movl count, %eax
	addl $s, %eax
	movl (%eax), %edx
	movl %edx, %eax
	cmpl $48, %eax
	je finish
	movl count, %eax
	incl %eax
	movl %eax, count
	jmp start
finish:
	pushl count
	pushl $fmt_int
	call printf
	addl $4, %esp
//epilog
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
