.data
fmt_string:
	.string "%d"
int:
	.space 4
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
	movl int, %eax
	movl $32, %ecx 
shear:
	shll $1, %eax
	movl $0, %ebx
	jnc print
	incl %ebx
print: 
	pushl %ecx
	pushl %eax
	pushl %ebx
	pushl $fmt_string
	call printf
	addl $8, %esp
	popl %eax
	popl %ecx
	loop shear
//epilog
	movl %ebp, %esp
	popl %ebp
	ret
